import sklearn
import joblib
import cv2
import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np
import albumentations
from torch.utils.data import Dataset, DataLoader
from PIL import Image
import time
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
cred = credentials.Certificate("pooleye-68d49-firebase-adminsdk-zkgaj-4f20e306ba.json")
firebase_admin.initialize_app(cred)
from playsound import playsound
import warnings
warnings.filterwarnings("ignore")
# load the binarized labels file
lb = joblib.load('lb.pkl')
class CustomCNN(nn.Module):
    def __init__(self):
        super(CustomCNN, self).__init__()
        self.conv1 = nn.Conv2d(3, 16, 5)
        self.conv2 = nn.Conv2d(16, 32, 5)
        self.conv3 = nn.Conv2d(32, 64, 3)
        self.conv4 = nn.Conv2d(64, 128, 5)
        self.fc1 = nn.Linear(128, 256)
        self.fc2 = nn.Linear(256, len(lb.classes_))
        self.pool = nn.MaxPool2d(2, 2)
    def forward(self, x):
        x = self.pool(F.relu(self.conv1(x)))
        x = self.pool(F.relu(self.conv2(x)))
        x = self.pool(F.relu(self.conv3(x)))
        x = self.pool(F.relu(self.conv4(x)))
        bs, _, _, _ = x.shape
        x = F.adaptive_avg_pool2d(x, 1).reshape(bs, -1)
        x = F.relu(self.fc1(x))
        x = self.fc2(x)
        return x


print('Loading model and label binarizer...')
lb = joblib.load('lb.pkl')
model = CustomCNN().cuda()
print('Model Loaded...')
model.load_state_dict(torch.load('model.pth'))
print('Loaded model state_dict...')
aug = albumentations.Compose([
    albumentations.Resize(224, 224),
    ])




# read until end of video

class detection:
  drowning = 0
  ThersholdForDrowning =  30;
  countDrowning=0
  countNormal=0

  def detectDrowning(self,video_path):
    #input from the video
    cap = cv2.VideoCapture(video_path)
    out = cv2.VideoWriter(str('test1.mp4'), cv2.VideoWriter_fourcc(*'mp4v'), 30, (1080,1920))
    fps = cap.get(cv2.CAP_PROP_FPS)
    classification="normal"
    if (cap.isOpened() == False):
        print('Error while trying to read video. Plese check again...')
    # get the frame width and height
    frame_width = int(cap.get(3))
    frame_height = int(cap.get(4))
    # define codec and create VideoWriter object
    #print(fps)
    while(cap.isOpened()):
        # capture each frame of the video
        start_time = time.time() # start time of the loop
        ret, frame = cap.read()
        if ret == True:
            model.eval()
            with torch.no_grad():
                # conver to PIL RGB format before predictions
                pil_image = Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
                pil_image = aug(image=np.array(pil_image))['image']
                pil_image = np.transpose(pil_image, (2, 0, 1)).astype(np.float32)
                pil_image = torch.tensor(pil_image, dtype=torch.float).cuda()
                pil_image = pil_image.unsqueeze(0)
                outputs = model(pil_image)
                _, preds = torch.max(outputs.data, 1)
                self.calculateDrowning(lb.classes_[preds])


            classification = lb.classes_[preds]
            activiy = "activiy: " +  classification
            
            cv2.putText(frame,activiy, (10,50), cv2.FONT_HERSHEY_SIMPLEX, 2.0, (0, 0, 200), 4)
            out.write(frame)
          
        else: 
            break   
        print("Frame Classified as: ",classification)
        print("FPS: ", int(1.0 / (time.time() - start_time))) 
    print("classified as normal:",self.countNormal)
    print("classified as drowning: ",self.countDrowning)
    return 0

  def calculateDrowning(self,classClassified):
    if classClassified=='drowning':
      self.drowning +=1
      if self.drowning == self.ThersholdForDrowning:
        playsound('alarm.mp3')
        self.alertDrowning()
        self.drowning = 0
      self.countDrowning +=1
    else:
        self.countNormal += 1
        self.drowning = 0
        


  def alertDrowning(self):
    organizationId = "Ahlyclub49301616522931404"
    sent = False
    text = "drowning alert"
    db = firestore.client()
    collectionBane = db.collection("lifeguardnotifications").add({
      "orgID": organizationId,
      "sent": sent,
      "text": text
    })
video_path = 'testVideos/DrowningFace.mp4'
d = detection()
d.detectDrowning(video_path)

