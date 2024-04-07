META
{
  Parser = Menu;
  After = zUnionMenu.d;
  Namespace = zTTSDialogues;
};

// Namespace = zTTSDialogues
// Important !!!
// Supporting Unicode symbols.
// File encoding: UTF-8 (without BOM).

// ------ Constants ------
const int Start_PY  = 1400;
const int Title_PY  = 450;
const int Menu_DY   = 550;
// Text
const int Text_PX   = 400;  // Position at left side
const int Text_SX   = 8000; // Size X
const int Text_SY   = 750;  // Size Y
const int Text_DY   = 120;  // Delta alignment
// Slider
const int Slider_PX = 6400; // Position at left side
const int Slider_SX = 1500; // Size X
const int Slider_SY = 600;  // Size Y
const int Slider_DY = 0;    // Delta alignment
// Choice
const int Choice_PX = 6400; // Position at left side
const int Choice_SX = 1500; // Size X
const int Choice_SY = 350;  // Size Y
const int Choice_DY = 120;  // Delta alignment

const string MenuBackPic   = "UnionMenu_BackPic.tga";
const string ItemBackPic   = "";
const string ChoiceBackPic = "MENU_CHOICE_BACK.TGA";
const string SliderBackPic = "MENU_SLIDER_BACK.TGA";
const string SliderPosPic  = "MENU_SLIDER_POS.TGA";
const string FontSmall     = "font_old_10_white.tga";
const string FontBig       = "font_old_20_white.tga";

var int CurrentMenuItem_PY;

// ------ Prototypes ------
func void InitializeBackPicturesAndFonts()
{
  MenuBackPic   = MENU_BACK_PIC;
  ItemBackPic   = MENU_ITEM_BACK_PIC;
  ChoiceBackPic = MENU_CHOICE_BACK_PIC;
  SliderBackPic = MENU_SLIDER_BACK_PIC;
  SliderPosPic  = MENU_SLIDER_POS_PIC;
  FontSmall     = MENU_FONT_SMALL;
  FontBig       = MENU_FONT_DEFAULT;
};

prototype C_EMPTY_MENU_DEF(C_MENU)
{
  InitializeBackPicturesAndFonts();
  C_MENU_DEF();
  backpic    = MenuBackPic;
  items[0]   = "";
  items[100] = "Union_menuitem_back";
  flags      = flags | MENU_SHOW_INFO;
};

instance C_MENU_ITEM_TEXT_BASE(C_MENU_ITEM_DEF)
{
  backpic        = ItemBackPic;
  posx           = Text_PX;
  posy           = Start_PY;
  dimx           = Text_SX;
  dimy           = Text_SY;
  flags          = flags | IT_EFFECTS_NEXT;
  onselaction[0] = SEL_ACTION_UNDEF;
};

instance C_MENUITEM_CHOICE_BASE(C_MENU_ITEM_DEF)
{
  backpic  = ChoiceBackPic;
  type     = MENU_ITEM_CHOICEBOX;
  fontname = FontSmall;
  posx     = Choice_PX;
  posy     = Start_PY + Choice_DY;
  dimx     = Choice_SX;
  dimy     = Choice_SY;
  flags    = flags & ~IT_SELECTABLE;
  flags    = flags | IT_TXT_CENTER;
};

instance C_MENUITEM_SLIDER_BASE(C_MENU_ITEM_DEF)
{
  backpic       = SliderBackPic;
  type          = MENU_ITEM_SLIDER;
  fontname      = FontSmall;
  posx          = Slider_PX;
  posy          = Start_PY + Slider_DY;
  dimx          = Slider_SX;
  dimy          = Slider_SY;
  flags         = flags & ~IT_SELECTABLE;
  flags         = flags | IT_TXT_CENTER;
  userstring[0] = SliderPosPic;
};

instance MenuItem_Opt_Headline(C_MENU_ITEM_DEF)
{
  type    = MENU_ITEM_TEXT;
  posx    = 0;
  posy    = Title_PY;
  dimx    = 8100;
  flags   = flags & ~IT_SELECTABLE;
  flags   = flags | IT_TXT_CENTER;
  text[0] = Str_GetLocalizedString(
    "zTTSDialogues НАСТРОЙКИ",
    "zTTSDialogues SETTINGS",
    "zTTSDialogues EINSTELLUNGEN",
    "USTAWIENIA zTTSDialogues"
  );
};

func int Act_OpenWebLink()
{
  Open_Link("https://github.com/Sefaris/zTTSDialogues");
  return 0;
};

instance MenuItem_Opt_Open_Link(C_MENU_ITEM_DEF)
{
  C_MENU_ITEM_TEXT_BASE();
  posy += MENU_DY * 8;

  posx             = 64;
  onselaction[0]   = SEL_ACTION_UNDEF;
  oneventaction[1] = Act_OpenWebLink;
  flags            = flags | IT_TXT_CENTER;
  text[0]          = Str_GetLocalizedString(
    "Открыть страницу проекта",
    "Open project page",
    "Projektseite öffnen",
    "Otwórz stronę projektu"
  );

  text[1]          = "https://github.com/Sefaris/zTTSDialogues";
};

// ------ Menu ------
instance MenuItem_Union_Auto_zTTSDialogues(C_MENU_ITEM_UNION_DEF)
{
  text[0]          = "zTTSDialogues";
  text[1] = Str_GetLocalizedString(
    "Наѝтройте параметры zTTSDialogues",
    "Configure zTTSDialogues settings",
    "zTTSDialogues-Einstellungen konfigurieren",
    "Zmień ustawienia zTTSDialogues"
  );
  onselaction[0]   = SEL_ACTION_STARTMENU;
  onselaction_s[0] = "zTTSDialogues:Menu_Opt_zTTSDialogues";
};

instance Menu_Opt_zTTSDialogues(C_EMPTY_MENU_DEF)
{
  Menu_SearchItems("zTTSDialogues:MENUITEM_OPT_zTTSDialogues_*");
};

instance MenuItem_Opt_zTTSDialogues_Headline(C_MENU_ITEM)
{
  MenuItem_Opt_Headline();
};

instance MenuItem_Opt_zTTSDialogues_ReplaceAllDialogues(C_MENU_ITEM)
{
  CurrentMenuItem_PY = 1;
  C_MENU_ITEM_TEXT_BASE();
  fontname = FontSmall;
  posy += Menu_DY * CurrentMenuItem_PY + Text_DY;
  
  text[0] = Str_GetLocalizedString(
    "Заменить все диалоги",
    "Replace all dialogues",
    "Alle Dialoge ersetzen",
    "Zastąp wszystkie dialogi"
  );
  text[1] = Str_GetLocalizedString(
    "заменить все диалоги на Windows TTS",
    "Replace all dialogues with Windows TTS",
    "Ersetzen Sie alle Dialoge durch Windows TTS",
    "Zastąp wszystkie dialogi Windows TTS"
  );
};

instance MenuItem_Opt_zTTSDialogues_ReplaceAllDialogues_Choice(C_MENU_ITEM_DEF)
{
  C_MENUITEM_CHOICE_BASE();
  posy += Menu_DY * CurrentMenuItem_PY;
  
  onchgsetoption        = "ReplaceAllDialogues";
  onchgsetoptionsection = "zTTSDialogues";
  text[0]               = Str_GetLocalizedString(
    "Выкл.|Вкл.",
    "Off|On",
    "Aus|Ein",
    "Wył.|Wł."
  );
};

instance MenuItem_Opt_zTTSDialogues_Language(C_MENU_ITEM)
{
  CurrentMenuItem_PY = 2;
  C_MENU_ITEM_TEXT_BASE();
  fontname = FontSmall;
  posy += Menu_DY * CurrentMenuItem_PY + Text_DY;
  
  text[0] = Str_GetLocalizedString(
    "Язык",
    "Language",
    "Sprache",
    "Język"
  );
  text[1] = Str_GetLocalizedString(
    "Предпочтительный язык для Windows TTS",
    "Preffered language for Windows TTS",
    "Bevorzugte Sprache für Windows TTS",
    "Preferowany język dla Windows TTS"
  );
};

instance MenuItem_Opt_zTTSDialogues_Language_Choice(C_MENU_ITEM_DEF)
{
  C_MENUITEM_CHOICE_BASE();
  posy += Menu_DY * CurrentMenuItem_PY;
  
  onchgsetoption        = "Language";
  onchgsetoptionsection = "zTTSDialogues";
  text[0]               = "Other|Russian|English|German|Polish|Romanian|Italian|Czech|Spanish";
};

instance MenuItem_Opt_zTTSDialogues_Gender(C_MENU_ITEM)
{
  CurrentMenuItem_PY = 3;
  C_MENU_ITEM_TEXT_BASE();
  fontname = FontSmall;
  posy += Menu_DY * CurrentMenuItem_PY + Text_DY;
  
  text[0] = Str_GetLocalizedString(
    "Пол",
    "Gender",
    "Geschlecht",
    "Płeć"
  );
  text[1] = Str_GetLocalizedString(
    "Предпочитаемый пол для Windows TTS",
    "Preferred gender of the Windows TTS",
    "Bevorzugtes Geschlecht der Windows TTS",
    "Preferowana płeć dla Windows TTS"
  );
};

instance MenuItem_Opt_zTTSDialogues_Gender_Choice(C_MENU_ITEM_DEF)
{
  C_MENUITEM_CHOICE_BASE();
  posy += Menu_DY * CurrentMenuItem_PY;
  
  onchgsetoption        = "Gender";
  onchgsetoptionsection = "zTTSDialogues";
  text[0]               = Str_GetLocalizedString(
    "Мужчина|Женщина",
    "Male|Female",
    "Männlich|Weiblich",
    "Mężczyzna|Kobieta"
  );
};

instance MenuItem_Opt_zTTSDialogues_VoiceRate(C_MENU_ITEM)
{
  CurrentMenuItem_PY = 4;
  C_MENU_ITEM_TEXT_BASE();
  fontname = FontSmall;
  posy += Menu_DY * CurrentMenuItem_PY + Text_DY;

  text[0] = Str_GetLocalizedString(
    "Скорость голоса",
    "Voice speed",
    "Sprechgeschwindigkeit",
    "Szybkość głosu"
  );
};

instance MenuItem_Opt_zTTSDialogues_VoiceRate_Choice(C_MENU_ITEM_DEF)
{
  C_MENUITEM_CHOICE_BASE();
  posy += Menu_DY * CurrentMenuItem_PY;
  
  onchgsetoption        = "VoiceRate";
  onchgsetoptionsection = "zTTSDialogues";
  text[0]               = "0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20";
};

instance MenuItem_Opt_zTTSDialogues_Open_Link(C_MENU_ITEM)
{
  MenuItem_Opt_Open_Link();
};