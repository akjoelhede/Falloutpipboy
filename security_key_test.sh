#!/bin/bash

# Function to check for a connected security key and grant access
check_security_key() {
    # Define the vendor and product ID of your security key
    local vendor_id="0483"  # Replace XXXX with your key's vendor ID
    local product_id="5741"  # Replace YYYY with your key's product ID

    # Use lsusb to check if the device is connected
    if lsusb | grep -q "ID $vendor_id:$product_id"; then
        echo "Security key is connected. Access granted."
        # Insert any command you want to execute upon successful detection
        # For example: open a secure application, start a VPN, etc.
    else
        echo "Security key is not connected. Access denied."
        # Handle the access denial case
    fi
}

# Example usage:
check_security_key

