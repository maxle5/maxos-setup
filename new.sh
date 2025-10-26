#!/usr/bin/env bash

timestamp=$(date +%s)
filename="migrations/${timestamp}.sh"

# prefill the script with shebang
echo -e "#!/usr/bin/env bash\n\n" > "$filename"

# open the file
nvim "$filename"
