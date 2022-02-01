module Fastlane
  module Actions

    class PublishCodeCoverageAction < Action
      
      COVERAGE_FILE_PATH = 'fastlane/code_coverage/index.html'

      def self.run(params)
        commit_sha = get_current_commit_sha()
        UI.message "Current commit SHA: #{commit_sha}"
        UI.message "Publishing coverage on Github"
        test_message(commit_sha)
        test_message1(commit_sha)
        test_message2(commit_sha)
        test_message4()
      # UI.message "Generating Slather report"
      #   Actions::SlatherAction.run(
      #     scheme: 'CITesting',
      #     proj: 'CITesting.xcodeproj',
      #     output_directory: "fastlane/code_coverage", 
      #     html: true,
      # )
      #   UI.message "Obtaining coverage number"
      #   code_coverage = get_code_coverage()
      #   UI.message "Code coverage: #{code_coverage}"
      #   UI.message "Getting commit SHA"
      #   commit_sha = get_current_commit_sha()
      #   UI.message "Current commit SHA: #{commit_sha}"
      #   UI.message "Publishing coverage on Github"
      #   publish_to_github("Code coverage: #{code_coverage}", commit_sha)
      end

      def self.test_message(commit_sha)
        GithubApiAction.run(
          server_url: "https://api.github.com",
          api_token: ENV["GITHUB_API_TOKEN"],
          http_method: "POST",
          path: "/repos/rleojoseph/bitrise-test-ci/statuses/#{commit_sha}",
          raw_body:"{\"state\":\"success\", \"description\": \"Hello World\", \"context\": \"coverage\"}",
          error_handlers: {
            404 => proc do |result|
              UI.message("Couldn't find resource: #{result[:json]}")
            end,
            '*' => proc do |result|
              UI.message("Unknown error: #{result[:json]}")
            end
          }
        ) do |result|
          UI.message("Code coverage updated for commit #{commit_sha}")
        end
      end
    
      def self.test_message1(commit_sha)
        GithubApiAction.run(
          server_url: "https://api.github.com",
          api_bearer: ENV["GITHUB_TOKEN"],
          headers: { 'Authorization' => "Bearer #{ENV["GITHUB_TOKEN"]}" },
          http_method: "POST",
          path: "/repos/rleojoseph/bitrise-test-ci/statuses/#{commit_sha}",
          raw_body:"{\"state\":\"success\", \"description\": \"Hello World\", \"context\": \"coverage\"}",
          error_handlers: {
            404 => proc do |result|
              UI.message("Couldn't find resource: #{result[:json]}")
            end,
            '*' => proc do |result|
              UI.message("Unknown error: #{result[:json]}")
            end
          }
        ) do |result|
          UI.message("Code coverage updated for commit #{commit_sha}")
        end
      end
      
      def self.test_message2(commit_sha)
        GithubApiAction.run(
          server_url: "https://api.github.com",
          api_bearer: ENV["GITHUB_TOKEN"],
          http_method: "POST",
          path: "/repos/rleojoseph/bitrise-test-ci/statuses/#{commit_sha}",
          raw_body:"{\"state\":\"success\"}",
          error_handlers: {
            404 => proc do |result|
              UI.message("Couldn't find resource: #{result[:json]}")
            end,
            '*' => proc do |result|
              UI.message("Unknown error: #{result[:json]}")
            end
          }
        ) do |result|
          UI.message("Code coverage updated for commit #{commit_sha}")
        end
      end

      def self.test_message4()
        GithubApiAction.run(
          server_url: "https://api.github.com",
          api_token: ENV["GITHUB_TOKEN"],
          http_method: "GET",
          path: "/repos/rleojoseph/bitrise-test-ci/README.md",
          error_handlers: {
            404 => proc do |result|
              UI.message("Something went wrong - I couldn't find it...")
            end,
            '*' => proc do |result|
              UI.message("test_message4: Unknown error: #{result[:json]}")
            end
          }
        ) do |result|
          UI.message("JSON returned: #{result[:json]}")
        end
      end
      
      def self.get_code_coverage
        # Coverage file path
        current_dir = Dir.pwd
        complete_coverage_file_path = "#{current_dir}/#{COVERAGE_FILE_PATH}"
        UI.message "Coverage file path: #{complete_coverage_file_path}"

        # Strings between coverage number
        first_term = "id=\"total_coverage\">"
        second_term = "</span>"

        # Check file existence and find coverage
        begin
          file = File.open(complete_coverage_file_path)
          file_data = file.read
          first_string = file_data.split(first_term, -1)[1]
          final_string = first_string.split(second_term, -1)[0]
          return final_string
        rescue Errno::ENOENT
          return nil
        end
      end

      def self.get_current_commit_sha
        commit_info = LastGitCommitAction.run(nil)
        commit_info[:commit_hash]
      end

      def self.publish_to_github(message, commit_sha)
        GithubApiAction.run(
          server_url: "https://api.github.com",
          api_token: ENV["GITHUB_API_TOKEN"],
          http_method: "POST",
          path: "/repos/rleojoseph/bitrise-test-ci/statuses/#{commit_sha}",
          raw_body:"{\"state\":\"success\", \"description\": \"#{message}\", \"context\": \"coverage\"}",
          error_handlers: {
            404 => proc do |result|
              UI.message("Couldn't find resource: #{result[:json]}")
            end,
            '*' => proc do |result|
              UI.message("Unknown error: #{result[:json]}")
            end
          }
        ) do |result|
          UI.message("Code coverage updated for commit #{commit_sha}")
        end
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end