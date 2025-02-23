#!/bin/bash

# Exit on error
set -e

# Function to validate version number
validate_version() {
    if [[ ! $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Error: Version must be in format X.Y.Z"
        exit 1
    fi
}

# Function to get current version from __init__.py
get_current_version() {
    grep -o '".*"' ownerrez_wrapper/__init__.py | cut -d'"' -f2
}

# Function to increment version
increment_version() {
    local current_version=$1
    local increment_type=$2
    
    IFS='.' read -r major minor patch <<< "$current_version"
    
    case $increment_type in
        major)
            echo "$((major + 1)).0.0"
            ;;
        minor)
            echo "${major}.$((minor + 1)).0"
            ;;
        patch)
            echo "${major}.${minor}.$((patch + 1))"
            ;;
        *)
            echo "Error: Invalid increment type. Use major, minor, or patch."
            exit 1
            ;;
    esac
}

# Function to update version in files
update_version() {
    local version=$1
    # Update version in __init__.py
    sed -i '' "s/__version__ = \".*\"/__version__ = \"$version\"/" ownerrez_wrapper/__init__.py
    # Update version in setup.py
    sed -i '' "s/version=\".*\"/version=\"$version\"/" setup.py
}

# Check if increment type argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <increment_type>"
    echo "increment_type: major, minor, or patch"
    echo "Example: $0 patch"
    exit 1
fi

INCREMENT_TYPE=$1
CURRENT_VERSION=$(get_current_version)
NEW_VERSION=$(increment_version "$CURRENT_VERSION" "$INCREMENT_TYPE")

echo "Current version: $CURRENT_VERSION"
echo "New version: $NEW_VERSION"
echo "Increment type: $INCREMENT_TYPE"
echo ""
read -p "Continue with release? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Run tests
echo "Running tests..."
pytest tests/ -v --cov=ownerrez_wrapper

# If tests pass, update version
echo "Updating version to $NEW_VERSION..."
update_version $NEW_VERSION

# Stage changes
git add ownerrez_wrapper/__init__.py setup.py

# Commit changes
git commit -m "Release version $NEW_VERSION"

# Create and push tag
git tag -a "v$NEW_VERSION" -m "Release version $NEW_VERSION"
git push origin main
git push origin "v$NEW_VERSION"

echo "Release $NEW_VERSION complete!"
echo "GitHub Actions will now:"
echo "1. Run tests again"
echo "2. Build the package"
echo "3. Publish to PyPI"