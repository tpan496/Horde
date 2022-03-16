README.txt

Includes `dat_to_lua.py` that converts the .txt or .dat file generated in `garrysmod/data/horde/` directory to a more lua-friendly format for creating addons.
Previously mentioned in the following message:
https://discord.com/channels/813172530130190336/813173156219060254/886249471497871360

Since most users are probably playing Garry's mod on Windows, which doesn't have the best environment for python, a conversion of the python script to a .exe file is preferred. This can be done using the py2exe library for Python3 in Windows.
(This task should preferably be done by a regular Windows user with a proper CLU python environment; johnlime tried it earlier on his Bootcamp and it was a pain. johnlime doesn't wanna do it.)

##### Usage of `dat_to_lua.py` #####
usage: dat_to_lua.py [-h] [-in INPUT_FILE_PATH] [-out OUTPUT_FILE_PATH]

optional arguments:
  -h, --help            show this help message and exit
  -in INPUT_FILE_PATH, --input_file_path INPUT_FILE_PATH
                        path to the config data
  -out OUTPUT_FILE_PATH, --output_file_path OUTPUT_FILE_PATH
                        output lua file name + path

example:
  python dat_to_lua.py -in enemies.txt -out enemies_organized.txt
