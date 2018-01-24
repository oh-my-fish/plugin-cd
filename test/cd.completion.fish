#!/usr/local/bin/fish

source (dirname (status -f))/../completions/cd.fish
set _test_path /tmp/omf-cd

function before
  mkdir -p "$_test_path"
  mkdir -p "$_test_path/.a"
  mkdir -p "$_test_path/a"
  mkdir -p "$_test_path/b"
  mkdir -p "$_test_path/b/b"
  mkdir -p "$_test_path/b/b1"
  mkdir -p "$_test_path/b/b2"
  mkdir -p "$_test_path/c"
  mkdir -p "$_test_path/c/~/h1"
  mkdir -p "$_test_path/c/~/h1/h1.1"
  mkdir -p "$_test_path/c/~/h2"

  set -e CDPATH
  set HOME $_test_path/c/~
end

function after
  set -e HOME
  rm -rf $_test_path
end

function suite_relative_path

  function test_empty_should_return_current_directories
    cd $_test_path
    set -l subject (__complete_omf_cd "")
    assert_equal ".a/ a/ b/ c/" $subject
  end
  
  function test_one_dot_only_should_return_directories_stating_with_a_dot
    cd $_test_path
    assert_equal "./ .a/" (__complete_omf_cd ".")
  end

  function test_two_dot_only_should_return_a_slash
    cd $_test_path
    assert_equal "../" (__complete_omf_cd "..")
  end

  function test_three_dot_only_should_return_a_slash
    cd $_test_path
    assert_equal ".../" (__complete_omf_cd "...")
  end

  function test_continous_slashs_should_not_change_the_results
    cd $_test_path
    assert_equal ".//./ .//.a/" (__complete_omf_cd ".//.")
  end

  function test_one_dot_ending_with_slash_should_return_current_directories
    cd $_test_path
    assert_equal "./.a/ ./a/ ./b/ ./c/" (__complete_omf_cd "./")
  end

  function test_two_dot_with_slash_should_return_parent_directories
    cd $_test_path/a
    assert_equal "../.a/ ../a/ ../b/ ../c/" (__complete_omf_cd "../")
  end

  function test_empty_path_should_return_empty
    cd $_test_path
    assert_empty (__complete_omf_cd "a/")
  end
end

function suite_absolute_path

  function test_root_slash_should_return_root_directories
    cd $_test_path
    set -l subject (__complete_omf_cd "/")
    assert (contains '/tmp/' $subject)
    assert (contains '/etc/' $subject)
  end

  function test_empty_should_return_current_directories
    cd $_test_path
    set -l subject (__complete_omf_cd "$_test_path/")
    assert_equal "$_test_path/.a/ $_test_path/a/ $_test_path/b/ $_test_path/c/" $subject
  end
  
  function test_one_dot_only_should_return_directories_stating_with_a_dot
    cd $_test_path
    assert_equal "$_test_path/./ $_test_path/.a/" (__complete_omf_cd "$_test_path/.")
  end

  function test_two_dot_only_should_return_a_slash
    cd $_test_path
    assert_equal "$_test_path/../" (__complete_omf_cd "$_test_path/..")
  end

  function test_three_dot_only_should_return_a_slash
    cd $_test_path
    assert_equal "$_test_path/.../" (__complete_omf_cd "$_test_path/...")
  end

  function test_one_dot_ending_with_slash_should_return_current_directories
    cd $_test_path
    assert_equal "$_test_path/./.a/ $_test_path/./a/ $_test_path/./b/ $_test_path/./c/" \
      (__complete_omf_cd "$_test_path/./")
  end

  function test_two_dot_with_slash_should_return_parent_directories
    cd $_test_path
    assert_equal "$_test_path/a/../.a/ $_test_path/a/../a/ $_test_path/a/../b/ $_test_path/a/../c/" \
      (__complete_omf_cd "$_test_path/a/../")
  end

  function test_empty_path_should_return_empty
    cd $_test_path
    assert_empty (__complete_omf_cd "$_test_path/a/")
  end

  function test_one_swung_should_return_a_slash
    cd $_test_path
    assert_equal "~/" (__complete_omf_cd "~")
  end

  function test_one_swung_with_slash_should_return_home_directories
    cd $_test_path
    assert_equal "~/h1/ ~/h2/" (__complete_omf_cd "~/")
  end

  function test_path_start_with_swung_should_return_correct_directories
    cd $_test_path
    assert_equal "~/h1/h1.1/" (__complete_omf_cd "~/h1/")
  end
end

function suite_with_cdpath
  function test_cdpath_different_with_current_should_return_merged_directories
    cd $_test_path
    set -g CDPATH "$_test_path/b"
    set -l subject (__complete_omf_cd "")
    set -e CDPATH
    assert_equal ".a/ a/ b/ b1/ b2/ c/" $subject
  end

  function test_cdpath_with_slash_should_not_make_differences
    cd $_test_path
    set -g CDPATH "$_test_path/b/"
    set -l subject (__complete_omf_cd "")
    set -e CDPATH
    assert_equal ".a/ a/ b/ b1/ b2/ c/" $subject
  end

  
  function test_cdpath_same_with_current_should_return_current_directories
    cd $_test_path
    set -g CDPATH "$_test_path"
    set -l subject (__complete_omf_cd "")
    set -e CDPATH
    assert_equal ".a/ a/ b/ c/" $subject
  end
end

if not set -q tank_running
  source (dirname (status -f))/helper.fish
  before
  tank_run
  after
end
