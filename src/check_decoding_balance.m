function check_decoding_balance(badTrials)

    % Takes a struct, badTrials (created using specify_bad_trials.m) and
    % indicates whether there are any stimuli, and how many stimuli there
    % are, for which a participant is missing all 4 trials. 

    % for each participant
    for i = 1:size(badTrials,2)
        
        % if the task is naming
        if strcmp(badTrials(i).Task,'naming')
            % initalise an index
            trialIndex = ones(400,1);
            % set the bad trials to zero
            trialIndex(badTrials(i).BadTrials) = 0;
            % sum over repeated presentations of each stimulus
            trialIndex = trialIndex(1:100) + trialIndex(101:200) + trialIndex(201:300) + trialIndex(301:400);
            % if there are any zeros
            if any(~trialIndex)
                % throw a warning
                warning(['Patient ', badTrials(i).Subject, ' is lacking any good trials for ', num2str(size(find(trialIndex == 0), 1)), ' stimuli.']);
            end
        elseif strcmp(badTrials(i).Task,'semanticjudgement')
            %% TODO: fill in
        end
    end
end