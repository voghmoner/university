%function to generate spikes with Poisson ISI
%AS 2009

%f - frequency  in Hz
%dt - time step in sec

function y=spikePoisson(f,dt);

    a=rand(1); % random number from a uniform distribution onthe interval [0.0; 1.0]

    if a<f*dt
        y=1;
    else
        y=0;
    end

return;


