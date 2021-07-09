Project 4 - instax

instax is a photo sharing app using Parse as its backend.

Time spent: **18** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [ ] Run your app on your phone and use the camera to take the photo
- [x] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [x] Show the username and creation time for each post
- [x] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [x] Display the profile photo with each post
  - [x] Tapping on a post's username or profile photo goes to that user's profile page
- [x] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [x] User can like a post and see number of likes for each post in the post details screen.
- [x] Style the login page to look like the real Instagram login page.
- [ ] Style the feed to look like the real Instagram feed.
- [ ] Implement a custom camera view.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How to extend the app by implementing a commenting feature.
2. How to use a collection view to show a grid of the user's posts on their profile page.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

1. App icon, launch screen, sign up, login, logout, user persistence:

![instax_signup_login_logout_persist](signup-login-logout-persist.gif) / ! [](signup-login-logout-persist.gif)

2. User feed: pull to refresh, infinite scrolling, segues to profile page through username and profile picture
![instax_feed_refresh_infinite_profile](refresh-feed-profile-infinite-optimized.gif) / ! [](refresh-feed-profile-infinite-optimized.gif)

3. Details view of post: like/unlike, segues to profile page through username and profile picture
![instax_details_username_like](detail-profile-like.gif) / ! [](detail-profile-like.gif)

4. Posting a photo and caption with progress HUD (select from photo library using simulator)  
![instax_compose_progress](compose-progressHUD-feed.gif) / ! [](compose-progressHUD-feed.gif)

5. Profile tab, changing profile picture, various segues to profile page
![instax_profile](profile-tab-picture-links.gif) / ! [](profile-tab-picture-links.gif)

6. Overview of core features (simplified due to file size constraints)
![instax_profile](instax-overview-optimized.gif) / ! [](instax-overview-optimized.gif)

GIF created with [EzGif](https://ezgif.com/video-to-gif).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [DateTools](https://github.com/MatthewYork/DateTools) - streamlines date and time handling in iOS


## Notes

It took me some time to get familiar with using Parse and Back4App, especially with regards to adding a profile picture for the User object and working between files and images. 

## License

    Copyright [2021] [Constance Horng]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
