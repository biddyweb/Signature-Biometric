function [distvect] = testTrait()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    file = 'USER';
    for i=1:5
        for j=2:40
            mat = readfile(strcat(file,int2str(i),'_',int2str(1),'.txt'));
            % Plot the point cloud, unchanged
            subplot(2, 2, 1), plot(mat(:,1), mat(:,2),'.');
            title(strcat('File 1 Set',int2str(i),' _ 1'));
            hold on;
            mat = moindreCarre(mat);
            data1 = translate(mat);
            % Display points after translation
            plot(data1(:,1), data1(:,2), 'r.');
            data1 = reduceNbPoints(data1);
            showBoundingBox(data1);
            hline = refline(0, 0);
            set(hline,'Color','k');
            
            mat = readfile(strcat(file,int2str(i),'_',int2str(j),'.txt'));
    
            % Plot the point cloud, unchanged
            subplot(2, 2, 3), plot(mat(:,1), mat(:,2),'.');
            title(strcat('File 2 Set',int2str(i),' _ ',int2str(j)));
            hold on;
    
            mat = moindreCarre(mat);
            data2 = translate(mat);
            % Display points after translation
            plot(data2(:,1), data2(:,2), 'r.');
            data2 = reduceNbPoints(data2);
            showBoundingBox(data2);
            hline = refline(0, 0);
            set(hline,'Color','k');
    
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
            distvect(i,j-1) = struct('Distance',Dist,'DiffPressure',diffpres,'DiffAzimuth',diffazi,'DiffAltitude', diffalt,'DiffAcceleration',diffacc,'DiffTemps',difftp,'DiffVitMoy', diffvm, 'DiffVitHoriz', diffvmh,'DiffVitVert', diffvmv, 'DiffVitMax', diffvmax,'DiffDeplacement',diffdepl,'DiffLongTrait', difftrait,'DiffRapport', diffrapp, 'DiffRapportX', diffXrapp, 'DiffRapportY', diffYrapp,'DiffSommeTan', diffTanSum, 'DiffTan', diffTan);
            figure;
        end
    end
    
end

