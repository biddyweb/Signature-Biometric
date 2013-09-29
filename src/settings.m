function settings()

  rdtw = zeros(0, 0);
  rcurv = zeros(0, 0);
  rfrac = zeros(0, 0);
  rpress = zeros(0, 0);

  for i=1:5
    if (i == 4)
      continue;
    end

    n = size(rdtw, 2) + 1;
    [ rdtw(n), rcurv(n), rfrac(n), rpress(n) ] = testDecision(i);

  end

  rdtw
  rcurv
  rfrac
  rpress

  dtw_floor = mean(rdtw)
  curv_floor = mean(rcurv)
  frac_floor = mean(rfrac)
  press_floor = mean(rpress)

    for i=1:5

    end

end
