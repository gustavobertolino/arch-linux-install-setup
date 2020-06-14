echo "Continue? [y/N]: "
read fsok
if ![ $fsok = 'y' ] && ![ $fsok = 'Y' ]
then
  echo ""
  echo "Exiting! Edit the script and run it again to continue..."
  exit 0
fi
