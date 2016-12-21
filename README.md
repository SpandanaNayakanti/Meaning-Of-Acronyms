# Meanings-Of-Acronym
This is a simple iPhone app created to look up meanings of Acronyms / Initialisms.

App supports iOS 7.0 and later.

App is developed using Storyboards and has one screen.

Acronyms & Meanings screen: This has a textfield which accepts valid Acronyms / Initialisms. On entering the text and hit "search" key, webservice is made and corresponding meanings are shown in a table view. .


Below API is used to fetch the meanings:

http://www.nactem.ac.uk/software/acromine/rest.html

It's a GET request

Cocoapods are used as dependency manager to add below projects:

"AFNetworking", "~> 2.0" (https://github.com/AFNetworking/AFNetworking)

'MBProgressHUD', '~> 0.9.1' (https://github.com/jdg/MBProgressHUD)
