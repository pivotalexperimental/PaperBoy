require 'cucumber'
require 'cucumber/rake/task'

import 'Specs/Rakefile'

PROJECT_NAME = "PaperBoy"
SCHEME_NAME = "App"
APP_NAME = "PaperBoy"
CONFIGURATION = "Release"
EXECUTABLE_NAME = "PaperBoy"

SPECS_TARGET_NAME = "Specs"

SDK_VERSION = "6.0"
PROJECT_ROOT = File.dirname(__FILE__)
BUILD_DIR = File.join(PROJECT_ROOT, "build")
TRACKER_ID = "879043"

TESTFLIGHT_API_TOKEN = ""
TESTFLIGHT_TEAM_TOKEN = ""
TESTFLIGHT_DISTRIBUTION_LIST = "Developers"

def build_configuration
  CONFIGURATION
end

def sdk_dir
  "#{xcode_developer_dir}/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator#{SDK_VERSION}.sdk"
end

# Xcode 4.3 stores its /Developer inside /Applications/Xcode.app, Xcode 4.2 stored it in /Developer
def xcode_developer_dir
  `xcode-select -print-path`.strip
end

def build_dir(effective_platform_name)
  File.join(BUILD_DIR, CONFIGURATION + effective_platform_name)
end

def system_or_exit(cmd, stdout = nil)
  puts "Executing #{cmd}"
  cmd += " >#{stdout}" if stdout
  system(cmd) or raise "******** Build failed ********"
end

def with_env_vars(env_vars)
  old_values = {}
  env_vars.each do |key,new_value|
    old_values[key] = ENV[key]
    ENV[key] = new_value
  end

  yield

  env_vars.each_key do |key|
    ENV[key] = old_values[key]
  end
end

def output_file(target)
  output_dir = if ENV['IS_CI_BOX']
    ENV['CC_BUILD_ARTIFACTS']
  else
    Dir.mkdir(BUILD_DIR) unless File.exists?(BUILD_DIR)
    BUILD_DIR
  end

  output_file = File.join(output_dir, "#{target}.output")
  puts "Output: #{output_file}"
  output_file
end

def kill_simulator
  system %Q[killall -m -KILL "gdb"]
  system %Q[killall -m -KILL "otest"]
  system %Q[killall -m -KILL "iPhone Simulator"]
end

task :default => [:trim_whitespace, :clean, :Specs_iphone, :Specs_ipad, :features]

desc "Trim whitespace"
task :trim_whitespace do
  system_or_exit %Q[git status --porcelain | awk '{if ($1 != "D" && $1 != "R") print $NF}' | grep -e '.*\.[cmh]$' | xargs sed -i '' -e 's/	/    /g;s/ *$//g;']
end

desc "Clean all targets"
task :clean do
  system_or_exit "rm -rf #{BUILD_DIR}/*", output_file("clean")
end

require 'tmpdir'

task :build_for_device do
  # if `git status --short`.length != 0
    # raise "******** Cannot push with uncommitted changes ********"
  # end

  system_or_exit("agvtool next-version -all")
  build_number = `agvtool what-version -terse`.chomp

  system_or_exit("git commit -am'Updated build number to #{build_number}'")
  system_or_exit(%Q[xcodebuild -project #{PROJECT_NAME}.xcodeproj -scheme #{SCHEME_NAME} -configuration #{build_configuration} -sdk iphoneos ARCHS=armv7 build SYMROOT=#{BUILD_DIR}], output_file("build_for_device"))
  system_or_exit("git push origin master")
end

task :archive => :build_for_device do
  system_or_exit(%Q[xcrun -sdk iphoneos PackageApplication #{BUILD_DIR}/#{build_configuration}-iphoneos/#{EXECUTABLE_NAME}.app -o #{BUILD_DIR}/#{build_configuration}-iphoneos/#{EXECUTABLE_NAME}.ipa])
end

task :archive_dsym_file do
    system_or_exit(%Q[zip -r #{BUILD_DIR}/#{build_configuration}-iphoneos/#{EXECUTABLE_NAME}.app.dSYM.zip #{BUILD_DIR}/#{build_configuration}-iphoneos/#{EXECUTABLE_NAME}.app.dSYM], output_file("build_all"))
end
namespace :testflight do
  task :deploy => [:clean, :archive, :archive_dsym_file] do

    file      = "#{BUILD_DIR}/#{build_configuration}-iphoneos/#{EXECUTABLE_NAME}.ipa"
    notes     = "Please refer to Tracker (https://www.pivotaltracker.com/projects/#{TRACKER_ID}) for further information about this build"
    dysmzip   = "#{BUILD_DIR}/#{build_configuration}-iphoneos/#{EXECUTABLE_NAME}.app.dSYM.zip"

    system_or_exit(%Q[curl http://testflightapp.com/api/builds.json -F file=@#{file} -F dsym=@#{dysmzip} -F api_token=#{TESTFLIGHT_API_TOKEN} -F team_token="#{TESTFLIGHT_TEAM_TOKEN}" -F notes="#{notes}" -F notify=True -F distribution_lists="#{TESTFLIGHT_DISTRIBUTION_LIST}"])
  end
end

Cucumber::Rake::Task.new(:features) do |t|
  ENV["WAIT_TIMEOUT"] = "5"
  t.cucumber_opts = "Frank/features --format pretty"
end

task :features => [:frank_build]

task :frank_build do
  system_or_exit("frank build")
end

task :Specs => [:Specs_iphone, :Specs_ipad]
