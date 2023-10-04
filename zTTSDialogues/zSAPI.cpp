// Supported with union (c) 2020 Union team
// Union SOURCE file

namespace GOTHIC_ENGINE {
	zSAPI::zSAPI() {
	}

	zSAPI::~zSAPI() {
		Release();
	}

	void zSAPI::Release() {
		if (voice)
		{
			voice->Release();
			voice = NULL;
		}
	}

	void zSAPI::Init() {
		HRESULT hr = CoCreateInstance(CLSID_SpVoice, NULL, CLSCTX_ALL, IID_ISpVoice, (void**)&voice);

		if (!SUCCEEDED(hr))
		{
			CMessageA::Error("Could not initialize voice", "zTTSDialogues Error");
			exit(0);
		}
	}

	bool zSAPI::IsDoneReading() {
		if (!voice)
			return true;

		SPVOICESTATUS status;
		voice->GetStatus(&status, NULL);
		if (status.dwRunningState == SPRS_DONE)
			return true;

		return false;
	}

	void zSAPI::ReloadSettings() {
		if (!voice)
			Init();

		voice->SetVolume(VoiceVolume);
		voice->SetRate(VoiceRate);

		CComPtr<IEnumSpObjectTokens> cpEnum;
		CComPtr<ISpObjectToken> cpToken;

		SpEnumTokens(L"HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Speech_OneCore\\Voices", L"Gender = " + Gender + L"; Language = " + LanguageID, NULL, &cpEnum);
		cpEnum->Next(1, &cpToken, NULL);
		voice->SetVoice(cpToken);

		cpEnum.Release();
		cpToken.Release();
	}

	oCNpc* zSAPI::GetCurrentSpeaker() {
		return currentspeaker;
	}

	int zSAPI::GetCurrentHandle() {
		return currenthandle;
	}

	void zSAPI::Read(const string& str, oCNpc* speaker, int handle) {
		ReloadSettings();

		currenthandle = handle;
		currentspeaker = speaker;

		DWORD flags = SPF_ASYNC | SPF_IS_NOT_XML | SPF_PURGEBEFORESPEAK;
		voice->Speak(str.AToW(CodePage), flags, NULL);
	}

	void zSAPI::StopReading() {
		Release();

		currentspeaker = nullptr;
		currenthandle = 0;
	}
}