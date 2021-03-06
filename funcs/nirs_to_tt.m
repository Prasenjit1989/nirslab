function tt = nirs_to_tt(test)

% nirs_to_tt(test) 
%
% Convert a Nirs test to a timetable.
% E.g. nirs_to_tsc(data.norm.nirsO.test(1)).
% 
% Returns a timetable according to the columns/fields in the Nirs data.
% Time in miliseconds is computed from sample numbers and sample rate.

warning('nirslab:deprecated', 'function %s is deprecated!', mfilename('fullpath'))
% Hint: to switch off these warning messages, use
% >> warning('off', 'nirslab:deprecated')

% compute time in milliseconds from sample numbers and sample rate
samp_num = test.samples{1};
Time = milliseconds(samp_num * (1000 / test.export_sample_rate));

% mangle orignal columns to obtain valid Matlab names
varnames = matlab.lang.makeValidName(test.legend(1:end));

% It seems that newer versions of Matlab after R2017a do not 
% make the rowtimes available as under the propertt 'Time'
% (i.e. tt.Time), but instead as the workspace name of 
% the first argument in the call to the timetable constructor. 
% Hence the time variable is called 'Time' rather than 'time' here...
tt = timetable(Time, test.samples{1:end}, 'VariableNames', varnames);

% copy some metadata in UserData field
tt.Properties.UserData.events =  test.events;
tt.Properties.UserData.export_sample_rate = test.export_sample_rate;
tt.Properties.UserData.legend = test.legend;
tt.Properties.UserData.events =  test.events;

end

