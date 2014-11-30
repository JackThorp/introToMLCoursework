data = load('../forstudents/cleandata_students.mat');
CBR = CBRinit(data.x, data.y);
save('CBR');