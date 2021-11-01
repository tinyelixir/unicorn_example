defmodule UnicornExampleTest do
  use ExUnit.Case
  doctest UnicornExample

  test "greets the world" do
    assert UnicornExample.hello() == :world
  end
end
