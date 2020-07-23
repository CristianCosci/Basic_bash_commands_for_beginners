# basic-bash-commands-and-script-shell-for-beginners
There are 6 basic exercises for beginners in linux system. It was an assignment for my Computer Science's university in the course of Operative Systems.

1) Extract (and print on standard output) from the / etc / passwd login-name and home file (first and sixth fields) as follows:
- only login-names that have the home in '/ home /'
- alphabetical order

example:
alice /home/alice
bob /home/bob
pippo /home/pippo



2) Print the list of all the file names contained in your home that have been modified in the last 2 minutes and that contain the word 'cookies' inside them



3) Write a bash script with the following operation:
- It receives one and only one argument, otherwise it returns an error
- If the argument is not a directory, it returns an error
- If the argument is a directory, create a tar.gz archive with the name of the directory given as input
- If the command to create the archive has failed, it returns an error
- If the creation command was successful, print the contents of the compressed archive on the std output
- If the archive already exists, it asks the user if it wants to overwrite it: if not, it exits, in the positive case I delete the old archive and recreate it

example:
bash~$ ls dir1/
file1.txt file2.txt
bash~$ ./crea_archivio.sh
To using this script: make_archive.sh directoryname
bash~$ ./crea_archivio.sh dir1 dir2
To using this script: make_archive.sh directoryname
bash~$ ./mkae_archive.sh dir1
make the directory dir1.tar.gz
archive creato con successo, il contenuto e':
dir1/
dir1/file1.txt
dir1/file2.txt
bash~$ ./make_archive.sh dir1
il file dir1.tar.gz already exist overwrite (S/N)?




4) Write a bash script that takes "k> = 2" input file names and hangs the first "k-1" files in the file passed as the last argument (k-th), 
writing the input files in the order from right to left.

example: 
myscript.sh file1 file2 file3 file4
-> file4 will contain in sequence file3 file2 file1



5) Writing a bash script that gives 2 input text files (f1 and f2) produces the following choice menu for the user:
- 1. remove both files
- 2. archive both files
- 3. hang the f1 file on the f2 file
- 4. exit

- Implement each function of the menu above
- For option 1, ask for confirmation before removal
- For option 2 produce the compressed archive f1f2.tar.gz (the name is given by the two names of the linked files)
- DO NOT use the builtin select to implement the menu


6) Data input a list of text files, each of which contains two numeric fields separated by space for each line.
Write a bash script that reads the second field of each file and calculates: sum, average and standard deviation, and prints a string with the following format on the std output:
[filename without extension] [number of lines in the file] [sum] [average] [standard deviation]
Finally print [number of total lines] [sum] [average] [standard deviation] of all files.
NB: manage any input values ​​that are not numbers (see example 2)

Example 1 (NB: arbitrary values, they may not be correct):
bash~$ cat file1.csv
1 20.0
2 15.5
3 25.3
bash~$ ./script.sh file1.csv file2.csv
file1 3 60.8 20.26 4.90
file2 10 10 5.03 0.05
TOT 13 70.8 12.6 4.8

example 2:
bash~$ cat file1.csv
1 20.0
2 uno
3 25.3
bash~$ ./script.sh file1.csv
error: I found a row that did not contain numbers
