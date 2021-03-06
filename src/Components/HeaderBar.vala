using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {

    static HeaderBar? instance;

    private StackManager stack_manager = StackManager.get_instance ();
    private RecipeFileManager recipe_file_manager = RecipeFileManager.get_instance ();
    private PDFExporter pdf_exporter = new PDFExporter ();
    public Gtk.Button return_button = new Gtk.Button ();
    public Gtk.Button download_button = new Gtk.Button ();
    private Granite.Widgets.ModeButton language_button = new Granite.Widgets.ModeButton ();
    private Gtk.Label title_label = new Gtk.Label ("");

    HeaderBar () {
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);

        generate_language_button ();
        generate_return_button ();
        generate_download_button ();

        this.pack_start (return_button);
        this.pack_start (language_button);
        this.pack_end (download_button);
        this.show_close_button = true;

        this.set_custom_title (title_label);
    }

    public static HeaderBar get_instance () {
        if (instance == null) {
            instance = new HeaderBar ();
        }
        return instance;
    }

    private void generate_language_button () {
        language_button.no_show_all = true;
        language_button.visible = false;
        language_button.margin = 1;
        language_button.notify["selected"].connect (on_language_button_changed);
    }

    private void generate_return_button () {
        return_button.label = _("Back");
        return_button.no_show_all = true;
        return_button.visible = false;
        return_button.get_style_context ().add_class ("back-button");
        return_button.clicked.connect (() => {
            stack_manager.get_stack ().visible_child_name = "list-view";
        });
    }

    private void generate_download_button () {
        download_button.label = _("Download");
        download_button.no_show_all = true;
        download_button.visible = false;
        download_button.get_style_context ().add_class ("download-button");
        download_button.clicked.connect (() => {
            pdf_exporter.export_as_pdf ();
        });
    }

    public void show_language_mode (bool answer) {
        language_button.visible = answer;
    }

    public void show_page_title (bool answer) {
        title_label.visible = answer;
    }

    public void show_return_button (bool answer) {
        return_button.visible = answer;
    }

    public void show_download_button (bool answer) {
        download_button.visible = answer;
    }

    public void update_languages_button (Array<string> languages) {
        language_button.clear_children ();

        for (int i = 0; i < languages.length ; i++) {
            var lang = languages.index (i);
            var label = new Gtk.Label (lang);
            label.get_style_context ().add_class ("view-mode-button");
            label.name = lang;

            language_button.append (label);
        }
    }

    public void update_page_title (Recipe recipe) {
        title_label.set_text (recipe.get_name () + " - " + recipe.get_author ());
    }

    private void on_language_button_changed () {
        var recipe = stack_manager.get_detail_recipe ();
        var lang = recipe.get_languages ().index (language_button.selected);

        var file = recipe_file_manager.get_recipe_file (recipe.get_id (), lang);
        var markdown_file = recipe_file_manager.file_to_string (file);

        recipe.set_markdown_file (markdown_file);
        stack_manager.set_detail_recipe (recipe);
    }
}
}
