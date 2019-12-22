defmodule Exavier.Config do
  @config_file ".exavier.exs"
  @config_file_content File.read!("priv/" <> @config_file)

  def get(key, default \\ nil) do
    file = config_file()

    unless exists?() do
      raise("Config file #{file} not found")
    end

    {configs, _binding} =
      file
      |> File.read!()
      |> Code.eval_string()

    Map.get(configs, key, default)
  end

  def exists?, do: config_file() |> File.exists?()

  def config_file, do: @config_file

  def config_file_content, do: @config_file_content
end
