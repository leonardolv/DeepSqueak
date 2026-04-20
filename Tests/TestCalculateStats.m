classdef TestCalculateStats < matlab.unittest.TestCase
    % TestCalculateStats Test the CalculateStats function

    methods(Test)
        function testBasicStats(testCase)
            % Create mock spectrogram image
            I = rand(100, 100);
            windowsize = 256;
            noverlap = 128;
            nfft = 256;
            SampleRate = 44100;
            Box = [1.0, 20.0, 0.5, 10.0];
            EntropyThreshold = 0.215;
            AmplitudeThreshold = 0.825;

            % Call the function
            stats = CalculateStats(I, windowsize, noverlap, nfft, SampleRate, Box, EntropyThreshold, AmplitudeThreshold);

            % Assertions
            testCase.verifyNotEmpty(stats.Entropy);
            testCase.verifyNotEmpty(stats.BeginTime);
            testCase.verifyNotEmpty(stats.EndTime);
            testCase.verifyNotEmpty(stats.DeltaTime);
            testCase.verifyNotEmpty(stats.PrincipalFreq);
            testCase.verifyNotEmpty(stats.LowFreq);
            testCase.verifyNotEmpty(stats.HighFreq);
            testCase.verifyNotEmpty(stats.DeltaFreq);
            testCase.verifyNotEmpty(stats.MeanPower);
            testCase.verifyNotEmpty(stats.Sinuosity);

            % Check basic math relationships
            testCase.verifyEqual(stats.DeltaTime, stats.EndTime - stats.BeginTime, 'AbsTol', 1e-5);
            testCase.verifyEqual(stats.DeltaFreq, stats.HighFreq - stats.LowFreq, 'AbsTol', 1e-5);
        end
    end
end
