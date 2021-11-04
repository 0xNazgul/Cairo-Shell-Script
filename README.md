# Cairo-Shell-Script
A simple script for cairo because I hate their terminal commands. 

### How To Use

* You'll first need to set up your cairo enviroment follow the instructions [here](https://www.cairo-lang.org/docs/quickstart.html)

* Add the script to the project  folder you are working in 

* Enable it in your working project folder: ```chmod +x script.sh```
	* Everytime you move the script to a new folder you must exucte this! 
	* Other wise you'll get ```-bash: ./script.sh: Permission denied``` 	 
* Then simply use ```./script.sh```

### Conclusion
I'll be adding more options and what not as I learn more about cairo (I'm sure there are more tedious commands)

P.S. If you hate having to always use ```source ~/cairo_venv/bin/activate``` then just go to your distro's .bashrc and add ```alias cairo='source ~/cairo_venv/bin/activate'``` under ```# Alias definitions``` personally I use a funtion to source, cd to my projects folder, then open the folder in vs code and finally run the script:
```bash
pro() {
	source ~/cairo_venv/bin/activate
	cd ~/cairo_venv/Projects/
	code .
	./script.sh
}
```
