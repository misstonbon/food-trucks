# San Francisco Food Trucks 
This repository contains the food truck coding challenge written in `ruby`.
### The Problem
Write a command line program that prints out a list of food trucks that are open at the current
date, when the program is being run. So if I run the program at noon on a Friday, I should see a
list of all the food trucks that are open then.
Please display the name and address of the trucks and sort the output alphabetically by name.
Please display results in pages of 10 trucks. That is: if there are more than 10 food trucks open,
the program should display the first 10, then wait for input from the user before displaying the
next 10 (or fewer if there are fewer than 10 remaining), and so on until there are no more food
trucks to display.
Please do not include tests in your submission, but please do write code that would be easy to test.

## Running the Program
Ruby should come preinstalled on your machine, but if you need to install it, click [here](https://www.ruby-lang.org/en/documentation/installation/).

1. Clone the respository and `cd` into it:
```
https://github.com/misstonbon/food-trucks.git && cd food-trucks
```
2. Install httparty gem:
```
gem install httparty
```
More info on httparty [here](https://github.com/jnunemaker/httparty)
3. Install terminal-table gem:
```
gem install terminal-table
```
More info on terminal-table gem [here](https://github.com/tj/terminal-table)

Run the program from the terminal:
```
ruby food_trucks.rb
```
## Additional Notes:
Q: What would I do differently if you were asked to build this as a full-scale web application?

A: Other than the obvious differences between CLI and GUI (ease of use for users not familiar with the terminal, prettier product, intuitive interaction), 
I'd build a single page app in React where I'd use promises to handle api data retrieval. Additionally, React would only reload updated DOM nodes instead of reloading the whole page.  
I'd also thoroughly test the app.
Furthermore, I'd handle pagination such that it loads more resources from the api if and only if the user requests it, thereby not consuming additional computing power/resources. 
I'd check for validity of all input on client and server side and would display a friendly message. 
There are really endless ways to offer the user more: I could possibly display additional information such as image (if available)  ensure more interactivity (for example, a map or directions, ability to save favorite food trucks and reminders on days when they are on desired street corner, etc.).


  
