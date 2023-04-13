import cv2

cam = cv2.VideoCapture(0)
haar_file = "haarcascade_frontalface_default.xml"
face_cap = cv2.CascadeClassifier(haar_file)
datasets = "DATASETS"
video_cap = cv2.VideoCapture(0)


email_format = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$'

status_options = ['Approved', 'Declined', 'Pending']