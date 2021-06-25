clear;
clc;
clf;
disp('Projectile Motion Calculator');
VNum=EC1('How many vectors are there?');
Vx=0;%sets Vx to zero
Vy=0;%sets Vy to zero
for i=1:VNum
    iEnding=GetOrdinalNumberEnding(i);%calls the function
    qua=sprintf('What quadrant is the %d%s vector in?',i,iEnding);%asks the user what quadrant
    quad=EC1(qua);%sends their reply to the function EC1 for error checking
    while quad>4 %while loop to ensure quadrant is only between 1 and 4
        disp('Quadrant can only between 1 and 4,try again!');
        qua=sprintf('What quadrant is the %d%s vector in?',i,iEnding);
    quad=EC1(qua);%EC1 deals with if it's less than 1 
    end
    ma=sprintf('What is the magnitude of the %d%s vector?',i,iEnding);%asking for magnitude
    mag(i)=EC1(ma);%sends response to error checking
    an=sprintf('What angle in degrees is the %d%s vector acting?',i,iEnding);%asking for direction
    ang(i)=EC2(an);%sends response for error checking
    while ang>90|ang<0% while loop to ensure angle is between 0 and 90
        disp('The angle must not be between 0 and 90 degrees,try again');
        ang(i)=EC2('What angle in degrees is the vector acting?');%sends response for error checking
    end
    if quad==1||quad==4%check if vector is in positive x
        vx=mag(i).*cosd(ang(i));%calculates xvalue of vector
    elseif quad==2||quad==3%check if vector is in negative x
        vx=-1*(mag(i).*cosd(ang(i)));%calculates xvalue of vector
    end
    if quad==1||quad==2%check if vector is in positive y
    vy=mag(i).*sind(ang(i));%calculates yvalue of vector
    elseif quad==3||quad==4%chcecks if vector is in negative y
        vy=-1*(mag(i).*sind(ang(i)));%calculates yvalue of vector
    end
    Vx=Vx+vx;%adds up all xvalues
    Vy=Vy+vy;%adds up all yvalues
    
end
R=sqrt(Vx^2+Vy^2);%calculates resultant
Direction=abs(atand((Vy/Vx)));%calculates direction of resultant
fprintf('The resultant vector is %.2f acting at an angle of %.2f degrees\n',R,Direction);
if Direction>90%checks if direction is greater than 90 then repeats the whole process before this if so
    disp('Angle must be in the first quadrant, try again!');
    VNum=EC1('How many vectors are there?');
Vx=0;
Vy=0;
for i=1:VNum
    iEnding=GetOrdinalNumberEnding(i);
    qua=sprintf('What quadrant is the %d%s vector in?',i,iEnding);
    quad=EC1(qua);
    while quad>4
        disp('Quadrant can only be between 1 and 4,try again!');
        qua=sprintf('What quadrant is the %d%s vector in?',i,iEnding);
    quad=EC1(qua);
    end
    ma=sprintf('What is the magnitude of the %d%s vector?',i,iEnding);
    mag(i)=EC1(ma);
    an=sprintf('What angle in degrees is the %d%s vector acting?',i,iEnding);
    ang(i)=EC2(an);
    while ang>90||ang<0
        disp('The angle must not be between 0 and 90 degrees,try again');
        ang(i)=EC2('What angle in degrees is the vector acting?');
    end
    if quad==1||quad==4
        vx=mag(i).*cosd(ang(i));
    elseif quad==2||quad==3
        vx=-1*(mag(i).*cosd(ang(i)));
    end
    if quad==1||quad==2
    vy=mag(i).*sind(ang(i));
    elseif quad==3||quad==4
        vy=-1*(mag(i).*sind(ang(i)));
    end
    Vx=Vx+vx;
    Vy=Vy+vy;
    
end
R=sqrt(Vx^2+Vy^2);
Direction=abs(atand((Vy/Vx)));
fprintf('The resultant vector is %.2f acting at an angle of %.2f degrees\n',R,Direction);
end
% this code is for projectile motion using the following 
% v=u+at, v^2 = u^2 +2as, s=ut+1/2 at^2;
%
disp('Press 1 for yes and 2 for no');%instructions to user
check1=EC1('Is your projetile landing at the same height?');%sends to error checking
while check1>2 % loop to make sure response can only be 1 or 2
        disp('Press 1 for yes and 2 for no');
        check1=EC1('Is your projetile landing at the same height?');% the ec1 function makes sure it can't be less than 1
end
check2=EC1('Are you trying to clear a wall?');% sends to error checking
while check2>2% loop to make sure response can only be 1 or 2
        disp('Press 1 for yes and 2 for no');
        check1=EC1('Is your projetile landing at the same height?');
end


if check1== 1 && check2 ==2%Asking if it's first scenario
    h=EC2('What is the height of the launching point?');%find out height and sends to error checking
    while h<0% while loop to make sure height cannot be less than 0
        disp('The height cannot be less than 0, try again!');
        h=EC2('What is the height of the launching point?');% sends to ec2 for error checking
    end
    u=R;% sets initial velocity to the resultant gotten in the vector calculator
    
    ux=u.*cosd(Direction);%calculates the x coordinate of the initial velocity
    uy=u.*sind(Direction);%calculates the y coordinate of the initial velocity
    a=-9.81;% sets acceleration to -9.81
    t1=(-uy+ sqrt(uy^2-4*(1/2*uy)*h))/(a);%calculates time
    t2=(-uy- sqrt(uy^2-4*(1/2*uy)*h))/(a);%calculates time

   
    if t2>t1% while loop to get the positive time value
        time=linspace(0,t2,100);%creates an array
        Sy= (uy.*time + 1/2*a.*time.^2)+h;%calculates Sy
        Sx= ux.*time;%calculates Sx
        
        plot(Sx,Sy);% plots Sy against Sx
        title('Projectile Motion')
        xlabel('Horizontal Displacement')
        ylabel('Verical Displacement')
        grid on;
        hold on;
        axis equal;
        for counter=1:length(time)% for loop to show an animationof each point
            plot(Sx(counter),Sy(counter),'ro');% plots each point
            pause(0.25);%gives an animation effect
        end
        hd=ux*t2;% calculates total horizontal distance
         fprintf('The time of flight of the object was %.2f seconds\nThe horizontal distance is %.2f metres\n',t2,hd);
    elseif t1>t2% while loop to get the positive time value
        time=linspace(0,t1,100);%creates an array
        Sy= (uy.*time + 1/2*a.*time.^2)+h;%calculates Sy
        Sx= ux.*time;%calculates Sx
        plot(Sx,Sy);% plots Sy against Sx
        grid on;
        hold on;
        axis equal;
        for counter=1:length(time)% for loop to show an animationof each point
            plot(Sx(counter),Sy(counter),'bo');%plots each point
            pause(0.25);%gives animation effect
        end
        hd=ux*t1;%calculates total horizontal distance
        fprintf('The time of flight of the object was %.2f seconds\n The horizontal distance is %.2f metres\n',t1,hd);
        
    end
    
elseif check1== 1 && check2 ==1%checks if it's scenario 2
    h=EC2('What is the height of the launching point?');%find out height and sends to error checking
    while h<0% while loop to make sure height cannot be less than 0
        disp('The height cannot be less than 0, try again!');
        h=EC2('What is the height of the launching point?');%finds out height and sends to error checking
    end
    wh=EC1('What is the height of the wall?');%finds out height of wall
    wd=EC1('What is the distance to the wall?');%finds out distance to wall from origin
    u=R;%sets initial velocity to resultant gotten from the vector calculator
    
    
    ux=u.*cosd(Direction);%calculates the x coordinate of the initial velocity
    uy=u.*sind(Direction);%calculates the y coordinate of the initial velocity
    a=-9.81;% sets acceleration to -9.81
    t1=(-uy+ sqrt(uy^2-4*(1/2*uy)*h))/(a);%calculates time
    t2=(-uy- sqrt(uy^2-4*(1/2*uy)*h))/(a);%calculates time
    t3=wd/ux;%calculates time projectile hits wall
    if t2>t1% while loop to get the positive time value
        time=linspace(0,t2,100);%creates an array
        Sy= (uy.*time + 1/2*a.*time.^2)+h;%calculates Sy
        Sx= ux.*time;%calculates Sx
        ss=(uy*t3 + 1/2*a*t3^2)+h;% calculates height of projectile when it hits wall
        rectangle('Position',[wd,h,0.5,wh]);%plots the wal
     
        title('Projectile Motion');
        xlabel('Horizontal Displacement');
        ylabel('Verical Displacement');
        grid on;
        hold on;
        axis equal;
        
        for counter=1:length(time)% for loop to show an animationof each point
             if Sx(counter)>wd && wh+h>ss%if the wall blocks the projectile
                 break%stops the projectile animation
             end
            pf=plot(Sx(counter),Sy(counter),'ro');% plots each point
                 
            pause(0.25);%gives an animation effect
                 
        end
        plot(Sx,Sy)%plots the trajectory of the projectile
         hd=ux*t2;% calculates total horizontal distance
        fprintf('The time of flight of the object if it hit the ground is %.2f seconds\nThe horizontal distance is %.2f metres\nThe height at which the projectile hit the wall is %.2f metres',t2,hd,ss);
        
         
        
    elseif t1>t2% while loop to get the positive time value
        time=linspace(0,t1,100);%creates an array
        Sy= (uy.*time + 1/2*a.*time.^2)+h;%calculates Sy
        Sx= ux.*time;%calculates Sx
        ss=(uy*t3 + 1/2*a*t3^2)+h;% calculates height of projectile when it hits wall
        rectangle('Position',[wd,h,0.5,wh]);%plots the wal
     
        title('Projectile Motion');
        xlabel('Horizontal Displacement');
        ylabel('Verical Displacement');
        grid on;
        hold on;
        axis equal;
        
        for counter=1:length(time)% for loop to show an animationof each point
             if Sx(counter)>wd && wh+h>ss%if the wall blocks the projectile
                 break%stops the projectile animation
             end
            pf=plot(Sx(counter),Sy(counter),'ro');% plots each point
                 
            pause(0.25);%gives an animation effect
                 
        end
        plot(Sx,Sy)%plots the trajectory of the projectile
                  
        hd=ux*t1;% calculates total horizontal distance
        fprintf('The time of flight of the object if it hit the ground is %.2f seconds\nThe horizontal distance is %.2f metres\nThe height at which the projectile hit the wall is %.2f metres\n',t1,hd,ss);
        
    end
    
elseif check1== 2 && check2 ==2%Asking if it's third scenario
    h=EC1('What is the height of the launching point?');%find out height and sends to error checking
    while h<0% while loop to make sure height cannot be less than 0
        disp('The height cannot be less than 0, try again!');
        h=EC2('What is the height of the launching point?');% sends to ec2 for error checking
    end
    u=R;% sets initial velocity to the resultant gotten in the vector calculator
    
    ux=u.*cosd(Direction);%calculates the x coordinate of the initial velocity
    uy=u.*sind(Direction);%calculates the y coordinate of the initial velocity
    a=-9.81;% sets acceleration to -9.81
    t1=(-uy+ sqrt(uy.^2-4*(a)*h))/(a);%calculates time
    t2=(-uy- sqrt(uy.^2-4*(a)*h))/(a);%calculates time

   
    if t2>t1% while loop to get the positive time value
        time=linspace(0,t2,100);%creates an array
        Sy= (uy.*time + 1/2*a.*time.^2)+h;%calculates Sy
        Sx= ux.*time;%calculates Sx
        
        plot(Sx,Sy);% plots Sy against Sx
        title('Projectile Motion')
        xlabel('Horizontal Displacement')
        ylabel('Verical Displacement')
        grid on;
        hold on;
        axis equal;
        for counter=1:length(time)% for loop to show an animationof each point
            plot(Sx(counter),Sy(counter),'ro');% plots each point
            pause(0.25);%gives an animation effect
        end
        hd=ux*t2;% calculates total horizontal distance
         fprintf('The time of flight of the object was %.2f seconds\nThe horizontal distance is %.2f metres\n',t2,hd);
    elseif t1>t2% while loop to get the positive time value
        time=linspace(0,t1,100);%creates an array
        Sy= (uy.*time + 1/2*a.*time.^2)+h;%calculates Sy
        Sx= ux.*time;%calculates Sx
        plot(Sx,Sy);% plots Sy against Sx
        grid on;
        hold on;
        axis equal;
        for counter=1:length(time)% for loop to show an animationof each point
            plot(Sx(counter),Sy(counter),'bo');%plots each point
            pause(0.25);%gives animation effect
        end
        hd=ux*t1;%calculates total horizontal distance
        fprintf('The time of flight of the object was %.2f seconds\n The horizontal distance is %.2f metres\n',t1,hd);
        
    end
    elseif check1== 2 && check2 ==1%checks if it's scenario 4
    h=EC1('What is the height of the launching point?');%find out height and sends to error checking
    while h<0% while loop to make sure height cannot be less than 0
        disp('The height cannot be less than 0, try again!');
        h=EC2('What is the height of the launching point?');%finds out height and sends to error checking
    end
    wh=EC1('What is the height of the wall?');%finds out height of wall
    wd=EC1('What is the distance to the wall?');%finds out distance to wall from origin
    u=R;%sets initial velocity to resultant gotten from the vector calculator
    
    
    ux=u.*cosd(Direction);%calculates the x coordinate of the initial velocity
    uy=u.*sind(Direction);%calculates the y coordinate of the initial velocity
    a=-9.81;% sets acceleration to -9.81
    t1=(-uy+ sqrt(uy^2-4*(a)*h))/(a);%calculates time
    t2=(-uy- sqrt(uy^2-4*(a)*h))/(a);%calculates time
    t3=wd/ux;%calculates time projectile hits wall
    if t2>t1% while loop to get the positive time value
        time=linspace(0,t2,100);%creates an array
        Sy= (uy.*time + 1/2*a.*time.^2)+h;%calculates Sy
        Sx= ux.*time;%calculates Sx
        ss=(uy*t3 + 1/2*a*t3^2)+h;% calculates height of projectile when it hits wall
        rectangle('Position',[wd,h,0.5,wh]);%plots the wal
     
        title('Projectile Motion');
        xlabel('Horizontal Displacement');
        ylabel('Verical Displacement');
        grid on;
        hold on;
        axis equal;
        
        for counter=1:length(time)% for loop to show an animationof each point
             if Sx(counter)>wd && wh+h>ss%if the wall blocks the projectile
                 break%stops the projectile animation
             end
            pf=plot(Sx(counter),Sy(counter),'ro');% plots each point
                 
            pause(0.25);%gives an animation effect
                 
        end
        plot(Sx,Sy)%plots the trajectory of the projectile
         hd=ux*t2;% calculates total horizontal distance
        fprintf('The time of flight of the object if it hit the ground is %.2f seconds\nThe horizontal distance is %.2f metres\nThe height at which the projectile hit the wall is %.2f metres\n',t2,hd,ss);
        
         
        
    elseif t1>t2% while loop to get the positive time value
        time=linspace(0,t1,100);%creates an array
        Sy= (uy.*time + 1/2*a.*time.^2)+h;%calculates Sy
        Sx= ux.*time;%calculates Sx
        ss=(uy*t3 + 1/2*a*t3^2)+h;% calculates height of projectile when it hits wall
        rectangle('Position',[wd,h,0.5,wh]);%plots the wal
     
        title('Projectile Motion');
        xlabel('Horizontal Displacement');
        ylabel('Verical Displacement');
        grid on;
        hold on;
        axis equal;
        
        for counter=1:length(time)% for loop to show an animationof each point
             if Sx(counter)>wd && wh+h>ss%if the wall blocks the projectile
                 break%stops the projectile animation
             end
            pf=plot(Sx(counter),Sy(counter),'ro');% plots each point
                 
            pause(0.25);%gives an animation effect
                 
        end
        plot(Sx,Sy)%plots the trajectory of the projectile
                  
        hd=ux*t1;% calculates total horizontal distance
        fprintf('The time of flight of the object if it hit the ground is %.2f seconds\nThe horizontal distance is %.2f metres\nThe height at which the projectile hit the wall is %.2f metres\n',t1,hd,ss);
        
    end
end


function Num=  EC1(VarName)%error checking function
InputStr=sprintf('%s',VarName);%gets the value provided
NumStr=input(InputStr,'s');%turns input to str
Num=str2double(NumStr);%turns any input to double
    while isnan(Num)|| ~isreal(Num)|| isinf(Num)||Num<1%while loop to error check
        if isnan(Num)
            fprintf('The response must be a number, try again!\n');%error if not a number
        elseif ~isreal(Num)
            fprintf('The response must be real, try again!\n');%error if not a real number
        elseif isinf(Num)
            fprintf('The response must be finite, try again!\n');%error if infinite
        else
            fprintf('The response cannot be less than 1, try again!\n');%error if number is less than 1
        end
        InputStr=sprintf('%s',VarName);%ask them to try again
NumStr=input(InputStr,'s');%turns input to str
Num=str2double(NumStr);%turns any input to double
    end
    
end


function Num=  EC2(VarName)%error checking function
InputStr=sprintf('%s',VarName);%asks for the value 
NumStr=input(InputStr,'s');%turns inout to str
Num=str2double(NumStr);%turns any input to double
    while isnan(Num)|| ~isreal(Num)|| isinf(Num)%while loop to error check
        if isnan(Num)
            fprintf('The response must be a number, try again!\n');%error if not a number
        elseif ~isreal(Num)
            fprintf('The response must be real, try again!\n');%error if not a real number
        elseif isinf(Num)
            fprintf('The response must be finite, try again!\n');%error if infinite
        end
        InputStr=sprintf('%s',VarName);%asks user to try again
NumStr=input(InputStr,'s');%turns inout to str
Num=str2double(NumStr);%turns any input to double
    end
end

function OrdinalNumEnding= GetOrdinalNumberEnding(Num)%function to add a number ending
NumLastTwo=mod(Num,100);
NumEnd=mod(NumLastTwo,10);
    if NumEnd>3||NumEnd==0||(NumLastTwo>10 && NumLastTwo<14)%adds 'th'
        OrdinalNumEnding='th';
    elseif NumEnd==3%adds 'rd'
        OrdinalNumEnding='rd';
    elseif NumEnd==2%adds 'nd
        OrdinalNumEnding='nd';
    elseif NumEnd==1%adds 'st'
        OrdinalNumEnding='st';
    else
        error('Problem with the superscript identification');%error if fails
        
    end
end



