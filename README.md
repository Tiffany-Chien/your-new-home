# YourNewHome
A IOS application enabling potential pet owners to find their dream pets.

# Your New Home

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Our goal is to enable potential owners to find the right pet, giving each shelter pet a chance to find a new home. We ask users for a short questionnaire help match our database of pets in local shelters to the user, using a simple liking mechanism to determine pets that you are interested in. Found a pet you love? We'll link you to the appropriate shelter so you can meet them yourselves.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Pet
- **Mobile:** IOS
- **Story:** Enable shelter pets find a new home, it's a good cause
- **Market:** Animal Shelter & adoption. Not a large market, just potential pet owners.
- **Habit:** Not addictive, unless you like cute pet photos
- **Scope:** Limited to shelter adoption. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
- [x] User have a login screen
- [x] User can register a new account
- [x] User can login 
- [x] User can easily sign-in multiple ways
- [x] User is automatically signed-in after signup
- [ ] User can select the attributes and characteristics of pets 
- [ ] User can add pets to intereseted/not interested by swiping left and right
- [ ] User can select the pets 

**Optional Nice-to-have Stories**

- [ ]Recommending system for pets 
- [ ] Rescue organization search
- [ ] Leave comments about a pet
- [ ] Leaderboard for each pets according to the number of likes
- [ ] All cats/dogs photo album
- [ ] Setting page for user to choose theme

### 2. Screen Archetypes
* Register
   * User register screen
* Login 
   * Allow User insert Id and password 
* Profile
   * Allow user to input and select preferred pet characteristics and attributes
   * Let user search by input attributes
* Detail
    * User can add pets to intereseted/not interested by swiping left and right
* Stream
    * User can add pets to intereseted/not interested by swiping left and right



### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Stream
* Profile
* Detail

**Flow Navigation** (Screen to Screen)

* Register
    * Stream
* Login 
    * Stream
* Profile
    * Stream
* Detail
* Stream
    * Detail

## Wireframes

![Demo](https://github.com/jhong97/YourNewHome/blob/master/Demo/wireframes.png)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models



| Property        | Type   | Description                                         |
| --------------- | ------ | --------------------------------------------------- |
| postId              | String | Unique id for each pet post                         |
| name            | String | Pet name                                            |
| organization_id | String | The rescue organization from pet                    |
| breed           | String | Pet's breed type                                    |
| color           | String | Pet's color                                         |
| age             | String | Pet's age                                           |
| gender          | String | Pet's gender                                        |
| size            | String | Pet's size                                          |
| likesCount      | Number | number of likes for the post                        |
| attributes      | String | Pet's attributes                                    |
| commentsCount   | Number | Number of comments that has been posted to an image |
| location |String|    City, state; latitude,longitude; or postal code.                                                 |
| Distance |Integer|    Return results within distance of location (in miles).                                                 |
| liked           | Bool   | If user has liked the same pet before               |




### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

List of network requests by screen
* Home Feed Screen
    *  (Ready/Get) Query all pets from local shelters
    ```let query = PFQuery(className:＂Pet")
    // Query all posts near user's home/preset location  
        query.whereKey("postId", equalTO: id)
        query.order(byDescending: "distance")
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
       if let error = error { 
          print(error.localizedDescription)
       } else if let posts = posts {
          print("Successfully retrieved \(posts.count) posts.")
      // TODO: Do something with posts...
       }
    }
    ```


    *  (Create/POST) Create a new like on a pet profile
    *  (Delete) Delete existing like
    *  (Read/GET) Query likes on pet profile
    *  (Read/Get) Query comments on pet profile

* Create Post Screen (Limited to shelter-employees/volunteers)
    * (Create/POST) Create a new pet profile object

* Profile Screen 
    * (Read/Get) Query pet profile object
    * (Update/Put) Update pet profile image
    * (Update/Put) Update pet availability status
    * (Update/Put) Set/update pet profile properties (id, name, org_id, etc...)

Week 10 Demo:
Link to GIF (https://imgur.com/a/QIaAQMU.gif)

Week 11 Demo:


<img src='/Demo/userLogin.gif' title='Video Walkthrough' width='150' alt='Video Walkthrough' />

Week 12 Demo:

<img src='/Demo/completedLogin.gif' title='Video Walkthrough' width='150' alt='Video Walkthrough' />
