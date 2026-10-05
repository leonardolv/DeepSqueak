classdef TestMergeBoxes < matlab.unittest.TestCase
    % TestMergeBoxes Test the merge_boxes function

    methods(Test)
        function testOverlappingBoxes(testCase)
            % Mock Inputs
            AllBoxes = [
                1.0, 20.0, 0.5, 10.0;
                1.1, 22.0, 0.6, 12.0; % Overlaps with first
                5.0, 40.0, 0.2,  5.0; % Does not overlap
            ];
            AllScores = [0.9; 0.85; 0.95];
            AllClass = categorical({'USV'; 'USV'; 'USV'});
            audio_info.Duration = 10.0;
            audio_info.SampleRate = 192000;
            merge_in_frequency = 0;
            score_cutoff = 0.5;
            pad_calls = 0;

            % Call the function
            Calls = merge_boxes(AllBoxes, AllScores, AllClass, audio_info, merge_in_frequency, score_cutoff, pad_calls);

            % Should merge first two boxes
            testCase.verifyEqual(size(Calls, 1), 2);

            % Verify that all accepted calls have a score above the cutoff
            testCase.verifyTrue(all(Calls.Score > score_cutoff));
        end

        function testEmptyBoxes(testCase)
            audio_info.Duration = 10.0;
            audio_info.SampleRate = 192000;
            Calls = merge_boxes([], [], categorical({}), audio_info, 0, 0.5, 0);
            testCase.verifyEqual(size(Calls, 1), 0);
            testCase.verifyTrue(ismember('Box', Calls.Properties.VariableNames));
            testCase.verifyTrue(ismember('Score', Calls.Properties.VariableNames));
            testCase.verifyTrue(ismember('Type', Calls.Properties.VariableNames));
            testCase.verifyTrue(ismember('Accept', Calls.Properties.VariableNames));
        end

        function testAllBelowScoreCutoff(testCase)
            AllBoxes = [1.0, 20.0, 0.5, 10.0];
            AllScores = [0.3];
            AllClass = categorical({'USV'});
            audio_info.Duration = 10.0;
            audio_info.SampleRate = 192000;
            Calls = merge_boxes(AllBoxes, AllScores, AllClass, audio_info, 0, 0.5, 0);
            testCase.verifyEqual(size(Calls, 1), 0);
            testCase.verifyTrue(ismember('Box', Calls.Properties.VariableNames));
            testCase.verifyTrue(ismember('Score', Calls.Properties.VariableNames));
            testCase.verifyTrue(ismember('Type', Calls.Properties.VariableNames));
            testCase.verifyTrue(ismember('Accept', Calls.Properties.VariableNames));
        end
    end
end
