BashCom
==========
**Powered by Twilio**

Communicate with friends and family via text messages and calls using the terminal.

Why use this
===================
**Simple** <br />
Interactive menu allows you to navigate through the script easily<br />
**Intuitive** <br />
Allows you to save contact information like an address book so you can forget numbers without guilt<br />
**Personalizable** <br />
Script is well commented, expandable, and made to be personalized towards your use<br />
**Easy to install**<br />
You can install this with bare minimum on your system. See below requirements for more insight.<br />
**Awesome**<br />
You are texting and making calls from the freaking terminal..need I say more?<br />

Requirements
====================
**Mac OS X**<br />
Nothing at all :) <br />

**Linux**<br />
Perl <br />
Curl <br />

**Windows** <br />
<a href="https://www.cs.drexel.edu/~kschmidt/Ref/cygwinSetup.html">Cygwin</a> with Curl and Perl packages <br />

Along with the platform requirements, you need a (non-sandbox) <a href="www.twilio.com">Twilio account</a>. Yes, this means that you might actually have to drop some money to get some credit but think it this way, each text message is 0.75cents, which is pretty damn cheap! Also, if you want some free credit to play around with, feel free to email Twilio Evangelist, <a href="http://www.jonmarkgo.com/">Jon Gottfried</a>. He's one awesome hacker and a really nice dude that will throw some free credit at you so you can try out the service. <br />


Installation
===================
1. Extract all files to a safe location (Documents or whereever you keep stuff that you don't trash)
2. Open terminal and change directory to this folder
3. Run command: sudo chmod 755 install_bashcom
4. Run command: sudo ./install_bashcom
5. Restart computer

```bash
bash$ cd /path/to/extracted/folder
bash$ sudo chmod 755 install_bashcom
bash$ sudo ./install_bashcom
```


Usage
===================
BashCom is made for both beginners and advanced users. Beginners can use the interactive menu to text, call, and save contacts. Advanced users can text and call using a single line.<br /><br />

**Beginners**<br />
Loads interactive menu:
```bash
Owner-bash$ bashcom
```
<br />

**Advanced Users**<br />
Text 1112224444 with the message "Hi there":
```bash
Owner-bash$ bashcom -t -n 1112224444 -m "Hi there"
```

Call 1112224444 with the message "Hi there":
```bash
Owner-bash$ bashcom -c -n 1112224444 -m "Hi there"
```


OPTIONS
===================
```bash
bashcom
-t 	Text
-c 	Call
-n 	PhoneNumber
-m 	Message Body
```
```bash
bashcom [[-h][-t][-c] [-n phonenumber] [-m message]]
```