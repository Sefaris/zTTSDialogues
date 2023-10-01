// Supported with union (c) 2020 Union team
// Union HEADER file

namespace GOTHIC_ENGINE {
	int VoiceRate = 1;
	int VoiceVolume = -1;
	bool ReplaceAllDialogues = false;
	bool ShouldRead = false;
	int Language = 1;
	wstring LanguageID;
	uint32 CodePage;
	wstring Gender = L"Male";

	class zSAPI {
	public:
		zSAPI();
		~zSAPI();

	public:
		void Read(const string& str, oCNpc* speaker, int handle);
		void StopReading();
		bool IsDoneReading();
		oCNpc* GetCurrentSpeaker();
		int GetCurrentHandle();
		void ReloadSettings();

	private:
		void Init();
		void Release();
		ISpVoice* voice;
		oCNpc* currentspeaker = nullptr;
		int currenthandle = 0;
	};
}