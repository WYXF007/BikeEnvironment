classdef bike3D_V2
    properties
        frame
        front
        rear
        handle
        bwheel
        ground
        fwheel
        SteerAngle
        TiltAngle
        BikeFacing
    end
    methods
        function obj = bike3D_V2()
            obj.SteerAngle = 0;
            obj.TiltAngle = 0;
            obj.BikeFacing = 0;
            
            obj.ground.f = [1 3 2 4];
            
            gSize = 5;
            
            
            obj.ground.v = [
                -gSize -gSize 0
                gSize gSize 0
                gSize -gSize 0
                -gSize gSize 1
            ];
            obj.ground.g = hgtransform;
            
            
            [obj.frame.f, obj.frame.v] = createRectangle(1/20,1,1/20);
            [obj.front.f, obj.front.v] = createRectangle(1/20,4/5,1/20);
            [obj.rear.f, obj.rear.v] = createRectangle(1/20,3/5,1/20);
            [obj.handle.f, obj.handle.v] = createRectangle(1/20,4/5,1/20);
            [obj.fwheel.f1, obj.fwheel.f2, obj.fwheel.v] = createCylinder(3/5,0.25/5,20);
            [obj.bwheel.f1, obj.bwheel.f2, obj.bwheel.v] = createCylinder(3/5,0.25/5,20);
            
            
            obj.front.v = (rotx(90)*obj.front.v')' + [0 0 6.5/5];
            obj.rear.v = (rotx(90)*obj.rear.v')' + [0 -10/5  5.5/5];
            obj.fwheel.v = (roty(90)*obj.fwheel.v')' + [0 0 3/5];
            obj.bwheel.v = (roty(90)*obj.bwheel.v')' + [0 -10/5 3/5];
            obj.frame.v = obj.frame.v + [0 -5/5 8/5];
            obj.handle.v = (rotz(90)*obj.handle.v')' + [0 0 10/5];
            
            
            obj.fwheel.g = hgtransform;     
            obj.bwheel.g = hgtransform;     
            obj.front.g = hgtransform;
            obj.rear.g = hgtransform;
            obj.handle.g = hgtransform;
            obj.frame.g = hgtransform;
            
            %bigfig
            obj.draw();
            view(3)
            box on
            axis vis3d
            daspect([1 1 1])
        end
        
        function updateRotations(obj)
            
            obj.fwheel.g.Matrix = ...
                makehgtform('yrotate',obj.TiltAngle)*makehgtform('zrotate',obj.SteerAngle+obj.BikeFacing);
%                 makehgtform('translate',[0 5 -9.75])*...
%                 makehgtform('yrotate',pi/2)*...
%                 makehgtform('xrotate',obj.SteerAngle)*...
                
%                 makehgtform('translate',[0 0 10]);
            
            obj.bwheel.g.Matrix = ...
                makehgtform('zrotate',-obj.BikeFacing)*makehgtform('yrotate',obj.TiltAngle);
%                 makehgtform('yrotate',pi/2)*...
%                 makehgtform('translate',[6.5 -5 0]);
%                 
%             
            obj.front.g.Matrix = ...
                makehgtform('yrotate',obj.TiltAngle)*makehgtform('zrotate',obj.SteerAngle+obj.BikeFacing);
%                 makehgtform('yrotate',-obj.SteerAngle)*...
%                 makehgtform('xrotate',pi/2)*...
%                 makehgtform('translate',[0 -2.5 -5]);
%                 
%             
            obj.rear.g.Matrix = ...
                makehgtform('zrotate',-obj.BikeFacing)*makehgtform('yrotate',obj.TiltAngle);
%                 makehgtform('xrotate',pi/2)*...
%                 makehgtform('translate',[0 -2.5 5]);
%                 
%             
            obj.handle.g.Matrix = ...
                makehgtform('yrotate',obj.TiltAngle)*makehgtform('zrotate',obj.SteerAngle+obj.BikeFacing);
%                 makehgtform('xrotate',obj.TiltAngle)*...
%                 makehgtform('zrotate',pi/2)*...
%                 makehgtform('translate',[5 0 1.75]);
%                 
%             
            obj.frame.g.Matrix = ...
                makehgtform('zrotate',-obj.BikeFacing)*makehgtform('yrotate',obj.TiltAngle);
            
        end
        
        function draw(obj)
            patch('Vertices',obj.fwheel.v,'Faces',obj.fwheel.f1,'FaceColor',[.3 .3 .3],'Parent',obj.fwheel.g)
            patch('Vertices',obj.fwheel.v,'Faces',obj.fwheel.f2,'FaceColor',[.1 .1 .1],'Parent',obj.fwheel.g)
            patch('Vertices',obj.bwheel.v,'Faces',obj.bwheel.f1,'FaceColor',[.3 .3 .3],'Parent',obj.bwheel.g)
            patch('Vertices',obj.bwheel.v,'Faces',obj.bwheel.f2,'FaceColor',[.1 .1 .1],'Parent',obj.bwheel.g)
            patch('Vertices',obj.frame.v,'Faces',obj.frame.f,'FaceColor',[1 0 0],'Parent',obj.frame.g)
            patch('Vertices',obj.front.v,'Faces',obj.front.f,'FaceColor',[1 0 0],'Parent',obj.front.g)
            patch('Vertices',obj.rear.v,'Faces',obj.rear.f,'FaceColor',[1 0 0],'Parent',obj.rear.g)
            patch('Vertices',obj.handle.v,'Faces',obj.handle.f,'FaceColor',[.75 .75 .75],'Parent',obj.handle.g)
            patch('Vertices',obj.ground.v,'Faces',obj.ground.f,'FaceColor',[.4 .1 .1],'Parent',obj.ground.g)
           
            drawnow
        end
        
        function fromData(obj, data)
            time = data.time;
            state = data.signals.values;
            
            N = length(state);
            index = 1;
            t0 = time(1);
            tmax = time(end);
            tic;
            
            try
                while index < N
                    t = toc;
                    index = floor(N *(t-t0)/(tmax-t0))+1;
                    
                    obj.SteerAngle = -state(index,3);
                    obj.TiltAngle = state(index,1);
                    obj.updateRotations();
                    obj.draw()
                    s = sprintf("t = %.2f s    theta = %.2f [DEG]   v = %.2f m/s",time(index),180/pi*state(index,1),state(index,5));
                    title(s);
                    
                end
            catch
                clc
                close all
            end
        end
        
        function fromStateFile(obj,filename)
            data = load(filename);
            data = data.sim_true_state;
            time = data.time;
            state = data.signals.values;
            
            N = length(state);
            index = 1;
            t0 = time(1);
            tmax = time(end);
            tic;
            
            try
                while index < N
                    t = toc;
                    index = floor(N *(t-t0)/(tmax-t0))+1;
                    
                    obj.SteerAngle = -state(index,3);
                    obj.TiltAngle = state(index,1);
                    obj.updateRotations();
                    obj.draw()
                    s = sprintf("t = %.2f s    theta = %.2f [DEG]   v = %.2f m/s",time(index),180/pi*state(index,1),state(index,5));
                    title(s);
                    
                end
            catch
                clc
                close all
            end
            
            
        end
        
        function fromDataAndPos(obj, data, pos)
            time = data.time;
            state = data.signals.values;

            p = pos.signals.values;
            %p = [-p(:,2) p(:,1)];
            
            hold on
            plot1 = plot(p(2,1),p(1,1),'.k');
            
            N = length(state);
            index = 1;
            t0 = time(1);
            tmax = time(end);
            tic;
            
            try
                while index < N
                    t = toc;
                    index = floor(N *(t-t0)/(tmax-t0))+1;
                    
                    obj.SteerAngle = -state(index,3);
                    obj.TiltAngle = state(index,1);
                    
                    obj.BikeFacing =  ...
                        -atan2(...
                            p(index+1,2)-p(index,2),...
                            p(index+1,1)-p(index,1)...
                        );
                    
                    disp(obj.BikeFacing);
                    
                    
                    obj.updateRotations();
                    obj.draw()
                    
                    %hold on
                    %plot(p(index,2),-p(index,1),'.k');
                    
                    pCurrent = p(1:index,:) - p(index,:);
                    
                    notbig = abs(pCurrent) < 5;
                    notbig = logical(notbig(:,1) .* notbig(:,2));
                    
                    pCurrent = pCurrent(notbig,:);
                    
                    
                    
                    plot1.XData = -(pCurrent(:,2));
                    plot1.YData = pCurrent(:,1);
                    
                    s = sprintf("t = %.2f s    theta = %.2f [DEG]   v = %.2f m/s",time(index),180/pi*state(index,1),state(index,5));
                    title(s);
                    
                end
            catch e
                disp(e)
                %disp(e.stack);
                clc
                close all
            end
        end
        
        function fromFile(obj,filename)
            data = load(filename);
            data = data.sim_angles;
            time = data.time;
            angles = data.signals.values;
            
            
            
            
            N = length(angles);
            index = 1;
            tic;
            try % Supress error if closed prematurely
                while index < N
                    
                    [~,index] = min(abs(time-toc));
                    
                    obj.SteerAngle = -angles(index,2);
                    obj.TiltAngle = angles(index,1);
                    obj.updateRotations();
                    obj.draw()
                    title(['t = ' num2str(time(index),3)]);
                end
            catch
                clc
                close all
            end
        end
    end
end


