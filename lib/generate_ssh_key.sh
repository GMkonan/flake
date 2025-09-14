#!/bin/bash


echo "--- SSH Key Generation using Ed25519 ---"
echo

read -p "Enter the email address to associate with the SSH key: " EMAIL
if [ -z "$EMAIL" ]; then
  echo "Error: Email address cannot be empty."
  exit 1
fi
echo

KEY_PATH="$HOME/.ssh/id_ed25519"
PUBLIC_KEY_PATH="$KEY_PATH.pub"

if [ -f "$KEY_PATH" ] || [ -f "$PUBLIC_KEY_PATH" ]; then
  echo "Warning: SSH key files already exist at $KEY_PATH(.pub)."
  read -p "Do you want to overwrite them? (y/N): " OVERWRITE
  if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
    echo "Aborting. No key generated."

    if [ -f "$PUBLIC_KEY_PATH" ]; then
        echo "You can use the existing public key:"
        cat "$PUBLIC_KEY_PATH"
    fi
    exit 1
  fi
  echo "Overwriting existing keys..."
  rm -f "$KEY_PATH" "$PUBLIC_KEY_PATH"
fi


echo "Generating a new Ed25519 SSH key..."
echo "You will be prompted to:"
echo "1. Enter a passphrase"
echo "2. Confirm the passphrase"
echo

# Use -f to specify the file directly, avoiding the location prompt
ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH"

# get result from the last run command ($?) and check if it didnt return a success (0) status, echo if so
if [ $? -ne 0 ]; then
  echo "Error: SSH key generation failed."
  exit 1
fi

if [ ! -f "$PUBLIC_KEY_PATH" ]; then
   echo "Error: Public key file ($PUBLIC_KEY_PATH) was not created."
   exit 1
fi
echo
echo "SSH key generated successfully."
echo

# Start ssh agent if wasnt started before...
echo "Starting the ssh-agent..."
eval "$(ssh-agent -s)"
echo

echo "Adding the SSH key to the ssh-agent..."
echo "You will be prompted for the passphrase if you set one."
ssh-add "$KEY_PATH"
if [ $? -ne 0 ]; then
  echo "Warning: Failed to add key to ssh-agent. You might need to add it manually later ('ssh-add $KEY_PATH')."
else
  echo "Key added to ssh-agent."
fi
echo

echo "--- Your Public SSH Key for GitHub ---"
echo "Copy the entire block below (starting with 'ssh-ed25519') and add it to your GitHub account:"
echo "---------------------------------------"
cat "$PUBLIC_KEY_PATH"
echo "---------------------------------------"
echo
echo "Instructions:"
echo "1. Go to your GitHub account settings."
echo "2. Navigate to 'SSH and GPG keys'."
echo "3. Click 'New SSH key' or 'Add SSH key'."
echo "4. Paste the copied key into the 'Key' field."
echo "5. Give it a title"
echo "6. Click 'Add SSH key'."

exit 0

