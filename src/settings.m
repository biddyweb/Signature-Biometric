function [total_err, coeff] = settings()

%  rdtw = zeros(0, 0);
%  rcurv = zeros(0, 0);
%  rfrac = zeros(0, 0);
%  rpress = zeros(0, 0);

%  for i=1:5
%    if (i == 4)
%      continue;
%    end

%    n = size(rdtw, 2) + 1;
%    [ rdtw(n), rcurv(n), rfrac(n), rpress(n) ] = testDecision(i);

%  end

%  rdtw
%  rcurv
%  rfrac
%  rpress

%  dtw_floor = mean(rdtw)
%  curv_floor = mean(rcurv)
%  frac_floor = mean(rfrac)
%  press_floor = mean(rpress)

  dtw_floor = 1.4130e+07;
  curv_floor =  1.3437e+03;
  frac_floor = 0.0184;
  press_floor = 48.9787;

  coeff = [0.222, 0.1678, 0.2531, 0.3571];
  sumV = 0;
  %coeff = rand(1, 4);
  %coeff = coeff / sum(coeff);  
 
  total_err = 0;
  
    for set=1:5
        if (set == 4)
            continue;
        end
        
        file = 'USER';
        other = set + 2;
        if other > 5
            other = other - 5;
        end

        score = zeros(1, 1);
        type = zeros(1, 1);
        index = 1;

        %%%% params
        correctNb = 20;
        wrongNb = 20;
        otherNb = 10;

        for i=1:20
            %i
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
                mat = moindreCarre(mat);
                data1 = translate(mat);
                [n2,r2] = boxcount(data1);
                df = -diff(log(n2)) ./ diff(log(r2));
                fracDim1 = mean(df(4:8));
                data1 = reduceNbPoints(data1);

                if type(index) == 2
                    mat = readfile(strcat(file,int2str(other),'_',int2str(i),'.txt'));
                else
                    mat = readfile(strcat(file,int2str(set),'_',int2str(j),'.txt'));
                end

                mat = moindreCarre(mat);
                data2 = translate(mat);
                [n2,r2] = boxcount(data2);
                df = -diff(log(n2))./diff(log(r2));
                fracDim2 = mean(df(4:8));
                data2 = reduceNbPoints(data2);

                % --- Shared pre-treatment ---

                % Maxe them have the same bounding box
                [data1, data2] = adaptBoundaries(data1, data2);

                % ----------------- End of pre-treatment ------------------------
                t = [transpose(data1(:,1)); transpose(data1(:,2))];
                r = [transpose(data2(:, 1));transpose(data2(:, 2))];
                [depl1,distTrait1,distrapp1,distXrapp1,distYrapp1,distTanSum1,distTan1] = deplacement(data1);
                [depl2,distTrait2,distrapp2,distXrapp2,distYrapp2,distTanSum2,distTan2] = deplacement(data2);
                pres1 = pressure(data1);
                pres2 = pressure(data2);
                [Dist, ~ , ~ ,~] = dtw(t, r);

                dtw_score = 1 - Dist / dtw_floor;
                curv_score = 1 - distancecurv(data1,data2,distTrait1,distTrait2) / curv_floor;
                frac_score = 1 - abs(fracDim1 - fracDim2) / frac_floor;
                press_score = 1 - abs(pres1-pres2) / press_floor;
                
                score(index) = coeff(1) * dtw_score + coeff(2) * curv_score + coeff(3) * frac_score + coeff(4) * press_score;
                
                index = index + 1;
            end
        end

        trues = score(find(type == 1));
        trues = sort(trues);

        
        V = trues(ceil(2 * size(trues, 2) / 100))
        sumV = sumV + V;
        
        wrongs = score(find(type == 0 | type == 2));
        err = 100 * size(find(wrongs >= V), 2) / size(wrongs, 2);
        total_err = total_err + err;
        
        %if (set == 5)
        %    subplot(2, 3, 4);
        %else
        %    subplot(2, 3, set);
        %end        
        %hold on;
        %title(strcat('err: ', num2str(err)));
        %plot(find(type == 1), score(find(type == 1)), '+g');
        %plot(find(type == 0), score(find(type == 0)), '+r');
        %plot(find(type == 2), score(find(type == 2)), '+c');
        %line(xlim, [V V]);
        %hold off;
    end
end
