
## Pooleye
Pooleye is a project made with the aim of drowning detection in swimming pools. Drowning is not like what we see in movies, the real features of drowning don't include shouting for help, but what is really present in drowning behavior is having a vertical body resurfacing up and down on the water surface. Our main goal is to classify two behavior, the first one which is the drowning behavior discussed earlier, and the other normal behavior of a swimmer which is called water treading which is specified by having a cycle like motion underwater.
Due to the lack of datasets, we collected our own dataset by recording videos underwater of both behaviors, then, we trained it on a CNN model scoring 97% accuracy.
## Classification Results
![](https://media.giphy.com/media/YE7h3I1vS336IU9Dst/giphy.gif) ![](https://media.giphy.com/media/IOGgyp6hYJ3d19wmOY/giphy.gif)
## System Setup
Our system consists of 5 main nodes, first, the nividia jetson with acts as our main processing unit, a camera that is placed underwater connected to the jetson, a speaker which acts as an alarm also connected to the jetson, a power bank to provide electricity to the jetson and at last a mobile application that receives notifications from firestore which are added by the jetson when it detects drowning.
![4db2da79-24a2-4c6e-a16c-70f93157d691](https://user-images.githubusercontent.com/43723746/121779450-f5d9e780-cb9b-11eb-984a-c6a3c063f3b7.jpg)
## Mobile Application
The Mobile App has three main users, first, the lifeguard receives the drowning notification directly and sends a report to the Medic to indicate whether the drowning case needs CPR only or if it needs an ambulance, or if it just was a false alarm. When the Lifeguard submits his report, the Medic gets notified about the drowning case, then he can also submit a report about the drowning case adding only comment to it. Then the OrganizationManager can view both reports submitted by the Lifeguard and the Medic, he can also delete anyone from the organization, also he can copy the organization ID in order to give it to a medic or a lifeguard to be able to signup to the organization.

## Application Screenshots
<img src="https://user-images.githubusercontent.com/43723746/121779710-587fb300-cb9d-11eb-89e1-2b54b4df5416.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/43723746/121779722-6b928300-cb9d-11eb-9875-aa4ebf132e59.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/43723746/121780256-d349cd80-cb9f-11eb-8989-4e79e4452833.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/43723746/121780288-f5435000-cb9f-11eb-8a15-c2ef99782503.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/43723746/121780398-5d923180-cba0-11eb-9ffa-62247e501395.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;">  <img src="https://user-images.githubusercontent.com/43723746/121780420-7e5a8700-cba0-11eb-8816-3e8797ee48f7.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/43723746/121780453-a0eca000-cba0-11eb-9ce2-2668b965cee3.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/43723746/121780453-a0eca000-cba0-11eb-9ce2-2668b965cee3.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;"> <img src="https://user-images.githubusercontent.com/43723746/121780571-41db5b00-cba1-11eb-8d7d-9c320bbc15cf.jpeg" alt="Uploading WhatsApp Image 2021-06-12 at 4.38.05 PM (3).jpeg…" width ="30%" height="30%" style="max-width:100%;"> 








