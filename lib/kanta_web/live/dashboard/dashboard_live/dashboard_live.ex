defmodule KantaWeb.Dashboard.DashboardLive do
  use KantaWeb, :live_view

  alias Kanta.Translations

  alias Kanta.Translations.Locale.Finders.GetLocaleTranslationProgress

  def mount(_params, _session, socket) do
    messages_count = Translations.get_messages_count()
    %{entries: domains, metadata: _domains_metadata} = Translations.list_domains()
    %{entries: contexts, metadata: _contexts_metadata} = Translations.list_contexts()
    %{entries: locales, metadata: _locales_metadata} = Translations.list_locales()

    socket =
      socket
      |> assign(:messages_count, messages_count)
      |> assign(:languages, locales)
      |> assign(:contexts, contexts)
      |> assign(:domains, domains)

    {:ok, socket}
  end

  def translation_progress(language) do
    GetLocaleTranslationProgress.find(language.id)
  end
end
