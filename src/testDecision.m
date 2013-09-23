function testDecision(set)

    file = 'USER';
    other = set + 2;
    if other > 5
        other = other - 5;
    end
    
    % dtw
    % fractal dim
    % length
    % curviline distances
    % pressure
    % diffRapport
    
    res_DTW = zeros(1, 1);
    res_fractalDimension = zeros(1, 1);
    res_traitLength = zeros(1, 1);
    res_curvDistance = zeros(1, 1);
    res_pressure = zeros(1, 1);
    res_xy = zeros(1, 1);
    
    type = zeros(1, 1);
    index = 1;
    
    %%%% params
    correctNb = 20;
    wrongNb = 20;
    otherNb = 10;
    
    for i=1:20
        i
        for j=(21 - correctNb):(20 + wrongNb + otherNb)

            if i == j || (i > 20 && j > 20)
              continue;
            end

            if j > (20 + wrongNb)
                type(index) = 2; % other tested
            elseif i <= 20 && j <= 20
                type(index) = 1; % correct tested
            else
                type(index) = 0; % wrong tested
            end

            mat = readfile(strcat(file,int2str(set),'_',int2str(i),'.txt'));
            % Plot the point cloud, unchanged
            %subplot(2, 2, 1), plot(mat(:,1), mat(:,2),'.');
            %title(strcat('File 1 Set',int2str(i),'_',int2str(j)));
            %hold on;
            mat = moindreCarre(mat);
            data1 = translate(mat);
            [n2,r2] = boxcount(data1);
            df = -diff(log(n2)) ./ diff(log(r2));
            fracDim1 = mean(df(4:8));
            %disp(['Fractal dimension, Df = ' num2str(mean(df(4:8))) ' +/- ' num2str(std(df(4:8)))])
            % Display points after translation
            %plot(data1(:,1), data1(:,2), 'r.');
            data1 = reduceNbPoints(data1);
            %showBoundingBox(data1);
            %hline = refline(0, 0);
            %set(hline,'Color','k');

            if type(index) == 2
                mat = readfile(strcat(file,int2str(other),'_',int2str(i),'.txt'));
            else
                mat = readfile(strcat(file,int2str(set),'_',int2str(j),'.txt'));
            end

            % Plot the point cloud, unchanged
            %subplot(2, 2, 3), plot(mat(:,1), mat(:,2),'.');
            %title(strcat('File 2 Set',int2str(i),' _ ',int2str(h)));
            %hold on;

            mat = moindreCarre(mat);
            data2 = translate(mat);
            [n2,r2] = boxcount(data2);
            df = -diff(log(n2))./diff(log(r2));
            fracDim2 = mean(df(4:8));
            %disp(['Fractal dimension, Df = ' num2str(mean(df(4:8))) ' +/- ' num2str(std(df(4:8)))])
            % Display points after translation
            %plot(data2(:,1), data2(:,2), 'r.');
            data2 = reduceNbPoints(data2);
            %showBoundingBox(data2);
            %hline = refline(0, 0);
            %set(hline,'Color','k');

            % --- Shared pre-treatment ---

            % Maxe them have the same bounding box
            [data1, data2] = adaptBoundaries(data1, data2);

            % ----------------- End of pre-treatment ------------------------
            t = [transpose(data1(:,1)); transpose(data1(:,2))];
            r = [transpose(data2(:, 1));transpose(data2(:, 2))];
            [depl1,distTrait1,distrapp1,distXrapp1,distYrapp1,distTanSum1,distTan1] = deplacement(data1);
            [depl2,distTrait2,distrapp2,distXrapp2,distYrapp2,distTanSum2,distTan2] = deplacement(data2);
            diffdepl = abs(depl1-depl2);
            difftrait = abs(distTrait1-distTrait2);
            diffrapp = abs(distrapp1-distrapp2);
            diffXrapp = abs(distXrapp1-distXrapp2);
            diffYrapp = abs(distYrapp1-distYrapp2);
            diffTanSum = abs(distTanSum1-distTanSum2);
            diffTan = abs(distTan1-distTan2);
            pres1 = pressure(data1);
            pres2 = pressure(data2);
            diffpres = abs(pres1-pres2);
            azi1 = azimuth(data1);
            azi2 = azimuth(data2);
            diffazi = abs(azi1-azi2);
            alt1 = altitude(data1);
            alt2 = altitude(data2);
            diffalt = abs(alt1-alt2);
            [tp1, vm1, vmv1, vmh1, vmax1, acc1] = dynamique(data1);
            [tp2, vm2, vmv2, vmh2, vmax2, acc2] = dynamique(data2);
            difftp = abs(tp1-tp2);
            diffvm = abs(vm1-vm2);
            diffvmv = abs(vmv1-vmv2);
            diffvmh = abs(vmh1-vmh2);
            diffacc = abs(acc1-acc2);
            diffvmax = abs(vmax1-vmax2);
            [Dist, D , k ,w] = dtw(t, r);
            %dist = distancecurv(data1,data2,distTrait1,distTrait2);
            dist2 = distanceTime(data1,data2);
            %distvect(i,j,h) = struct('Distance',Dist,'DistanceCurv', dist, 'DistanceTime', dist2, 'DistanceCum', Dist+dist+dist2,'DiffPressure',diffpres,'DiffAzimuth',diffazi,'DiffAltitude', diffalt,'DiffAcceleration',diffacc,'DiffTemps',difftp,'DiffVitMoy', diffvm, 'DiffVitHoriz', diffvmh,'DiffVitVert', diffvmv, 'DiffVitMax', diffvmax,'DiffDeplacement',diffdepl,'DiffLongTrait', difftrait,'DiffRapport', diffrapp, 'DiffRapportX', diffXrapp, 'DiffRapportY', diffYrapp,'DiffSommeTan', diffTanSum, 'DiffTan', diffTan)
            %drawnow;
            %clf reset;
            %diffFrac = abs(fracDim1 - fracDim2);
            
            res_DTW(index) = Dist;
            res_fractalDimension(index) = abs(fracDim1 - fracDim2);
            res_traitLength(index) = abs(distTrait1-distTrait2);
            res_curvDistance(index) = distancecurv(data1,data2,distTrait1,distTrait2);
            res_pressure(index) = abs(pres1-pres2);
            res_xy(index) = abs(distrapp1-distrapp2);
            
            index = index + 1;
        end
    end

    % printing results
    
    %res = [res_DTW', res_fractalDimension', res_traitLength', res_curvDistance', res_pressure', res_xy'];
    %coeffs = [0.1, 0.5, 0.1, 0.1, 0.1, 0.1];
    
    %norms = mean(res)f
    %rn = zeros(size(res))
    %for k=1:size(res, 2)
    %   rn(:,k) = res(:,k) / norms(k)
    %end

    %trues = zeros(1, 1);
    %t = 1;
    %wrongs = zeros(1, 1);
    %w = 1;
    %randWrongs = zeros(1, 1);
    %rw = 1;

    subplot(2, 3, 1);
    hold on;
    title(strcat('DTW: ', num2str(mean(res_DTW(find(type == 1))))));
    plot(find(type == 1), res_DTW(find(type == 1)), '+g');
    plot(find(type == 0), res_DTW(find(type == 0)), '+r');
    plot(find(type == 2), res_DTW(find(type == 2)), '+c');
    hold off;
    
    subplot(2, 3, 2);
    hold on;
    title(strcat('fractalDimension: ', num2str(mean(res_fractalDimension(find(type == 1))))));
    plot(find(type == 1), res_fractalDimension(find(type == 1)), '+g');
    plot(find(type == 0), res_fractalDimension(find(type == 0)), '+r');
    plot(find(type == 2), res_fractalDimension(find(type == 2)), '+c');
    hold off;
    
    subplot(2, 3, 3);
    hold on;
    title(strcat('trait length: ', num2str(mean(res_traitLength(find(type == 1))))));
    plot(find(type == 1), res_traitLength(find(type == 1)), '+g');
    plot(find(type == 0), res_traitLength(find(type == 0)), '+r');
    plot(find(type == 2), res_traitLength(find(type == 2)), '+c');
    hold off;
    
    subplot(2, 3, 4); 
    hold on;
    title(strcat('curviline distance: ', num2str(mean(res_curvDistance(find(type == 1))))));
    plot(find(type == 1), res_curvDistance(find(type == 1)), '+g');
    plot(find(type == 0), res_curvDistance(find(type == 0)), '+r');
    plot(find(type == 2), res_curvDistance(find(type == 2)), '+c');
    hold off;
    
    subplot(2, 3, 5);
    hold on;
    title(strcat('pressure: ', num2str(mean(res_pressure(find(type == 1))))));
    plot(find(type == 1), res_pressure(find(type == 1)), '+g');
    plot(find(type == 0), res_pressure(find(type == 0)), '+r');
    plot(find(type == 2), res_pressure(find(type == 2)), '+c');
    hold off;
    
    subplot(2, 3, 6);
    hold on;
    title(strcat('x/y: ', num2str(mean(res_xy(find(type == 1))))));
    plot(find(type == 1), res_xy(find(type == 1)), '+g');
    plot(find(type == 0), res_xy(find(type == 0)), '+r');
    plot(find(type == 2), res_xy(find(type == 2)), '+c');
    hold off;
    return
    
    disp(['Corrects']);
    disp(['DTW: ' ...
        num2str(mean(res_DTW(find(type == 1)))) ...
        ' - ' ...
        num2str(std(res_DTW(find(type == 1))) / (mean(res_DTW(find(type == 1)))))
        ])
    disp(['fractalDimension: ' ...
        num2str(mean(res_fractalDimension(find(type == 1)))) ...
        ' - ' ...
        num2str(std(res_fractalDimension(find(type == 1))) / mean(res_fractalDimension(find(type == 1))))
        ])
    disp(['traitLength: ' ...
        num2str(mean(res_traitLength(find(type == 1)))) ...
        ' - ' ...
        num2str(std(res_traitLength(find(type == 1))) / mean(res_traitLength(find(type == 1))))
        ])
    disp(['curvDistance: ' ...
        num2str(mean(res_curvDistance(find(type == 1)))) ...
        ' - ' ...
        num2str(std(res_curvDistance(find(type == 1))) / mean(res_curvDistance(find(type == 1))))
        ])
    disp(['pressure: ' ...
        num2str(mean(res_pressure(find(type == 1)))) ...
        ' - ' ...
        num2str(std(res_pressure(find(type == 1))) / mean(res_pressure(find(type == 1))))
        ])
    disp(['xy: ' ...
        num2str(mean(res_xy(find(type == 1)))) ...
        ' - ' ...
        num2str(std(res_xy(find(type == 1))) / mean(res_xy(find(type == 1))))
        ])

    disp(['Faux experimentés']);
    disp(['DTW: ' ...
        num2str(mean(res_DTW(find(type == 0)))) ...
        ' - ' ...
        num2str(std(res_DTW(find(type == 0))) / (mean(res_DTW(find(type == 0)))))
        ])
    disp(['fractalDimension: ' ...
        num2str(mean(res_fractalDimension(find(type == 0)))) ...
        ' - ' ...
        num2str(std(res_fractalDimension(find(type == 0))) / mean(res_fractalDimension(find(type == 0))))
        ])
    disp(['traitLength: ' ...
        num2str(mean(res_traitLength(find(type == 0)))) ...
        ' - ' ...
        num2str(std(res_traitLength(find(type == 0))) / mean(res_traitLength(find(type == 0))))
        ])
    disp(['curvDistance: ' ...
        num2str(mean(res_curvDistance(find(type == 0)))) ...
        ' - ' ...
        num2str(std(res_curvDistance(find(type == 0))) / mean(res_curvDistance(find(type == 0))))
        ])
    disp(['pressure: ' ...
        num2str(mean(res_pressure(find(type == 0)))) ...
        ' - ' ...
        num2str(std(res_pressure(find(type == 0))) / mean(res_pressure(find(type == 0))))
        ])
    disp(['xy: ' ...
        num2str(mean(res_xy(find(type == 0)))) ...
        ' - ' ...
        num2str(std(res_xy(find(type == 0))) / mean(res_xy(find(type == 0))))
        ])
    
    disp(['Faux aléatoires']);
    disp(['DTW: ' ...
        num2str(mean(res_DTW(find(type == 2)))) ...
        ' - ' ...
        num2str(std(res_DTW(find(type == 2))) / (mean(res_DTW(find(type == 2)))))
        ])
    disp(['fractalDimension: ' ...
        num2str(mean(res_fractalDimension(find(type == 2)))) ...
        ' - ' ...
        num2str(std(res_fractalDimension(find(type == 2))) / mean(res_fractalDimension(find(type == 2))))
        ])
    disp(['traitLength: ' ...
        num2str(mean(res_traitLength(find(type == 2)))) ...
        ' - ' ...
        num2str(std(res_traitLength(find(type == 2))) / mean(res_traitLength(find(type == 2))))
        ])
    disp(['curvDistance: ' ...
        num2str(mean(res_curvDistance(find(type == 2)))) ...
        ' - ' ...
        num2str(std(res_curvDistance(find(type == 2))) / mean(res_curvDistance(find(type == 2))))
        ])
    disp(['pressure: ' ...
        num2str(mean(res_pressure(find(type == 2)))) ...
        ' - ' ...
        num2str(std(res_pressure(find(type == 2))) / mean(res_pressure(find(type == 2))))
        ])
    disp(['xy: ' ...
        num2str(mean(res_xy(find(type == 2)))) ...
        ' - ' ...
        num2str(std(res_xy(find(type == 2))) / mean(res_xy(find(type == 2))))
        ])

    
    return
    
    %hold on;
    %for k=1:size(res, 1)
        %rn = res(k, :) ./ max(abs(res(k, :))); % normalization
        %r = coeffs * rn';
%        r = res(k, :)
%        if type(k) == 1
            %plot(k, r, '+g');
%            trues(t) = r';
%            t = t + 1;
%        else
%            if type(k) == 0
                %plot(k, r, '+r');
%                wrongs(w) = r';
%                w = w + 1;
%            else
                %plot(k, r, '+c');
%                randWrongs(rw) = r';
%                rw = rw + 1;
%            end
%        end
%    end    
    
    %[~, i] = sort(trues, 'descend');
    %V = trues(i(ceil(2 * size(i, 2) / 100)));
        
    %err = 0;
    %wrongs_sorted = sort(wrongs);
    %for n=1:size(wrongs, 2)
    %   if  wrongs_sorted(n) > V
    %      err = (n - 1) / size(wrongs, 2) * 100;
    %      break;
    %   end
    %end
   
    %line(xlim, [V V]);
    %V
    %err
end

