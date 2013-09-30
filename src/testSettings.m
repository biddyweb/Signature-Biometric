function testSettings()

minErr = 400;

while (1)
    [err, coeff] = settings();
    if (err < minErr)
         minErr = err;
        coeff
        err
    end
end

end