# OwnerRez API Wrapper

A Python wrapper for the OwnerRez API. This package provides a simple and intuitive interface to interact with the OwnerRez API v2.

## Requirements

- Python 3.10 or higher

## Installation

```bash
pip install ownerrez-wrapper
```

## Python Usage

```python
from ownerrez_wrapper import API
from datetime import datetime

# Initialize the API client
api = API(username="your_username", token="your_token")

# Get all properties
properties = api.getproperties()
for prop in properties:
    print(f"Property: {prop.name} (ID: {prop.id})")

# Get bookings for a property
bookings = api.getbookings(
    property_id=123,
    since_utc=datetime(2024, 1, 1)
)
for booking in bookings:
    print(f"Booking: {booking.arrival} to {booking.departure}")

# Get a specific booking
booking = api.getbooking(booking_id=456)
print(f"Guest ID: {booking.guest_id}")

# Get guest details
guest = api.getguest(guest_id=789)
print(f"Guest: {guest.first_name} {guest.last_name}")

# Check if a property is currently booked
is_booked = api.isunitbooked(property_id=123)
print(f"Property is booked: {is_booked}")
```

## API Documentation

### API Class Methods

- `getproperties()` -> List[Property]
  - Returns a list of all properties

- `getproperty(property_id: int)` -> Property
  - Get details for a specific property
  - Parameters:
    - property_id: The property ID

- `getbookings(property_id: int, since_utc: datetime)` -> List[Booking]
  - Get bookings for a specific property since a given date
  - Parameters:
    - property_id: The property ID
    - since_utc: DateTime object for the start date

- `getbooking(booking_id: int)` -> Booking
  - Get details for a specific booking
  - Parameters:
    - booking_id: The booking ID

- `getguest(guest_id: int)` -> Guest
  - Get details for a specific guest
  - Parameters:
    - guest_id: The guest ID

- `isunitbooked(property_id: int)` -> bool
  - Check if a property is currently booked
  - Parameters:
    - property_id: The property ID

### Data Models

The API returns strongly-typed objects that provide a rich interface to the OwnerRez data. For detailed documentation of all data models, including all available fields and usage examples, see [Data Models Documentation](docs/models.md).

Main models:
- `Property`: Contains property details (id, name, bedrooms, etc.)
- `Booking`: Contains booking information (arrival, departure, guest, etc.)
- `Guest`: Contains guest information (name, contact details, etc.)

Supporting models:
- `Address`: Physical address information
- `EmailAddress`: Email contact information
- `Phone`: Phone contact information
- `Charge`: Booking charge information
- `DoorCode`: Property access codes

## CLI Tool (for testing)

A command-line interface is included for testing and debugging. You can provide credentials via environment variables or a `.env` file:

```bash
# Using .env file
echo "OWNERREZ_USERNAME=your_username" > .env
echo "OWNERREZ_TOKEN=your_token" >> .env

# List properties
ownerrez properties

# Get property details
ownerrez property 123

# Check bookings
ownerrez bookings 123 --since 2024-01-01

# Get booking details
ownerrez booking 456
```

## Development

To set up the development environment:

```bash
git clone https://github.com/gmoorevt/ownerrez-wrapper.git
cd ownerrez-wrapper
pip install -e ".[dev]"
```

To run tests:

```bash
pytest
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

- Geody Moore (geody.moore@gmail.com)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
