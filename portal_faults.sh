#!/bin/bash

# Directory for storing portal fault reasons
mkdir -p fault_logs

# List of sectors with potential for faults
sectors=(
  "Sector_A"
  "Sector_B"
  "Sector_C"
  "Sector_D"
  "Sector_E"
  "Sector_F"
)

# Statuses indicating faults
fault_statuses=("Closed" "Under Maintenance")

# List of reasons for portal faults
reasons=(
  "Misalignment with the Planar Grid."
  "Overload of Astral Residues."
  "Interference from a Wild Magic Surge."
  "Corruption by Abyssal Energy."
  "Infiltration of Modron Sequencing Errors."
  "Decay of Ancient Runes."
  "Elemental Imbalance Affecting Portal Coherence."
  "Psychic Disruptions from Nearby Thought Forms."
  "Temporal Fluctuations Disturbing Portal Stability."
  "Faulty Enchantment Circuitry."
  "Planar Bleed-Through from Adjacent Realities."
  "Misfired Conjuration Spells."
  "Overconsumption of Mana Reserves."
  "Disturbances from Celestial or Infernal Alignments."
  "Sabotage by Rival Planeswalkers."
)

# Generate a file for each reason
for i in "${!reasons[@]}"; do
  # Generate random sector and status (either 'Closed' or 'Under Maintenance')
  sector_index=$(( RANDOM % ${#sectors[@]} ))
  status_index=$(( RANDOM % ${#fault_statuses[@]} ))
  sector="${sectors[sector_index]}"
  status="${fault_statuses[status_index]}"

  # Generate random portal number for each sector
  portal_number=$(( RANDOM % 30 + 1 ))  # Portal numbers between 1 and 100

  # File name with "portal_number" and the actual portal number and sector
  filename="fault_logs/portal_number${portal_number}_${sector}"

  # Compose the content for each file
  echo "Portal Number: $portal_number" > "$filename"
  echo "Sector: $sector ($status)" >> "$filename"
  echo "Fault Reason: ${reasons[i]}" >> "$filename"
done

echo "Generated files named 'portal_numberXX_SectorX' with portal numbers, sectors, and reasons for portal faults in 'fault_logs' directory."
