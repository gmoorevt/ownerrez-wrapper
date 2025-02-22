# Data Models

## Property

Represents a property in the OwnerRez system.

```python
@dataclass
class Property:
    active: Optional[bool]              # Whether the property is active
    address: Optional[Address]          # Property address object
    bathrooms: Optional[int]            # Total number of bathrooms
    bathrooms_full: Optional[int]       # Number of full bathrooms
    bathrooms_half: Optional[int]       # Number of half bathrooms
    bedrooms: Optional[int]             # Number of bedrooms
    check_in: Optional[str]             # Check-in time (e.g., "16:00")
    check_in_end: Optional[str]         # End of check-in window
    check_out: Optional[str]            # Check-out time (e.g., "11:00")
    currency_code: Optional[str]        # Currency code (e.g., "USD")
    display_order: Optional[int]        # Display order in listings
    external_display_order: Optional[int]# External display order
    external_name: Optional[str]        # Name used on external sites
    id: Optional[int]                   # Unique property ID
    internal_code: Optional[str]        # Internal reference code
    key: Optional[UUID]                 # Unique UUID
    latitude: Optional[int]             # Property latitude
    longitude: Optional[int]            # Property longitude
    max_adults: Optional[int]           # Maximum number of adults allowed
    max_children: Optional[int]         # Maximum number of children allowed
    max_guests: Optional[int]           # Maximum total guests allowed
    max_pets: Optional[int]             # Maximum number of pets allowed
    name: Optional[str]                 # Property name
    owner_id: Optional[int]             # Property owner ID
    property_type: Optional[str]        # Type of property
    public_url: Optional[str]           # Public listing URL
    thumbnail_url: Optional[str]        # Thumbnail image URL
    thumbnail_url_large: Optional[str]  # Large thumbnail URL
    thumbnail_url_medium: Optional[str] # Medium thumbnail URL
    living_area: Optional[int]          # Living area size
```

## Booking

Represents a booking/reservation in the system.

```python
@dataclass
class Booking:
    adults: Optional[int]               # Number of adults
    arrival: Optional[datetime]         # Arrival date/time
    booked_utc: Optional[datetime]      # When the booking was made
    canceled_utc: Optional[datetime]    # When/if the booking was canceled
    charges: Optional[List[Charge]]     # List of charges
    check_in: Optional[str]            # Check-in time
    check_in_end: Optional[str]        # End of check-in window
    check_out: Optional[str]           # Check-out time
    children: Optional[int]            # Number of children
    cleaning_date: Optional[datetime]  # Scheduled cleaning date
    currency_code: Optional[str]       # Currency code
    departure: Optional[datetime]      # Departure date/time
    door_codes: Optional[List[DoorCode]]# Access codes
    form_key: Optional[str]           # Form identifier
    guest: Optional[Guest]            # Guest details
    guest_id: Optional[int]           # Guest ID
    id: Optional[int]                 # Booking ID
    infants: Optional[int]            # Number of infants
    is_block: Optional[bool]          # If this is a block booking
    listing_site: Optional[str]       # Source listing site
    notes: Optional[str]              # Booking notes
    owner_id: Optional[int]           # Property owner ID
    pending_until_utc: Optional[datetime]# Pending expiration
    pets: Optional[int]               # Number of pets
    platform_email_address: Optional[str]# Platform contact email
    platform_reservation_number: Optional[str]# Platform booking reference
    property_id: Optional[int]        # Property ID
    quote_id: Optional[int]           # Quote ID
    status: Optional[str]             # Booking status
    title: Optional[str]              # Booking title
    total_amount: Optional[int]       # Total booking amount
    total_host_fees: Optional[int]    # Total host fees
    total_owed: Optional[int]         # Amount still owed
    total_paid: Optional[int]         # Amount paid
    total_refunded: Optional[int]     # Amount refunded
    type: Optional[str]               # Booking type
```

## Guest

Represents a guest in the system.

```python
@dataclass
class Guest:
    addresses: Optional[List[Address]]          # List of addresses
    email_addresses: Optional[List[EmailAddress]]# List of email addresses
    first_name: Optional[str]                   # First name
    id: Optional[int]                          # Guest ID
    last_name: Optional[str]                   # Last name
    notes: Optional[str]                       # Guest notes
    phones: Optional[List[Phone]]              # List of phone numbers
```

## Supporting Models

### Address

```python
@dataclass
class Address:
    city: Optional[str]               # City
    country: Optional[str]            # Country
    id: Optional[int]                 # Address ID
    is_default: Optional[bool]        # If this is the default address
    postal_code: Optional[str]        # Postal/ZIP code
    province: Optional[str]           # Province
    state: Optional[str]              # State
    street1: Optional[str]            # Street address line 1
    street2: Optional[str]            # Street address line 2
    type: Optional[str]               # Address type
```

### EmailAddress

```python
@dataclass
class EmailAddress:
    address: Optional[str]            # Email address
    id: Optional[int]                 # Email ID
    is_default: Optional[bool]        # If this is the default email
    type: Optional[str]               # Email type
```

### Phone

```python
@dataclass
class Phone:
    extension: Optional[str]          # Phone extension
    id: Optional[int]                 # Phone ID
    is_default: Optional[bool]        # If this is the default phone
    number: Optional[str]             # Phone number
    type: Optional[str]               # Phone type
```

### Charge

```python
@dataclass
class Charge:
    amount: Optional[int]             # Charge amount
    commission_amount: Optional[int]   # Commission amount
    description: Optional[str]         # Charge description
    expense_id: Optional[int]         # Related expense ID
    is_channel_managed: Optional[bool] # If managed by channel
    is_commission_all: Optional[bool]  # If commission applies to all
    is_expense_all: Optional[bool]     # If expense applies to all
    is_taxable: Optional[bool]        # If charge is taxable
    owner_amount: Optional[int]        # Owner's portion
    owner_commission_percent: Optional[int]# Owner commission %
    position: Optional[int]           # Display position
    rate: Optional[int]               # Rate amount
    rate_is_percent: Optional[bool]    # If rate is a percentage
    surcharge_id: Optional[int]       # Related surcharge ID
    tax_id: Optional[int]             # Related tax ID
    type: Optional[str]               # Charge type
```

### DoorCode

```python
@dataclass
class DoorCode:
    code: Optional[str]               # Access code
    lock_names: Optional[str]         # Associated lock names
```

## Usage Examples

### Working with Properties

```python
# Get a property and access its details
property = api.getproperties()[0]
print(f"Property: {property.name}")
print(f"Location: {property.address.city}, {property.address.state}")
print(f"Capacity: {property.max_guests} guests, {property.bedrooms} bedrooms")
```

### Working with Bookings

```python
# Get a booking and access its details
booking = api.getbooking(booking_id=123)
print(f"Guest: {booking.guest.first_name} {booking.guest.last_name}")
print(f"Stay: {booking.arrival} to {booking.departure}")
print(f"Total Amount: ${booking.total_amount}")

# Access charges
for charge in booking.charges:
    print(f"Charge: ${charge.amount} - {charge.description}")
```

### Working with Guests

```python
# Get a guest and access their contact information
guest = api.getguest(guest_id=456)
print(f"Name: {guest.first_name} {guest.last_name}")

# Get primary email
primary_email = next((email for email in guest.email_addresses if email.is_default), None)
if primary_email:
    print(f"Email: {primary_email.address}")

# Get primary phone
primary_phone = next((phone for phone in guest.phones if phone.is_default), None)
if primary_phone:
    print(f"Phone: {primary_phone.number}")
``` 