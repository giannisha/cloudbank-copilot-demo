<script lang="ts">
	import { onMount } from 'svelte';

	export let userId: string, username: string, token: string;

	function getTokenSync() {
		var request = new XMLHttpRequest();
		request.open(
			'GET',
			'https://defaultdd2e859741374579972ba0198b5816.aa.environment.api.powerplatform.com/powervirtualagents/botsbyschema/cr54e_copilotDemoV2/directline/token?api-version=2022-03-01-preview',
			false
		);
		request.setRequestHeader('accept', 'application/json');
		request.send(null);

		if (request.status === 200) {
			return JSON.parse(request.responseText);
		}
	}

	const msalConfig = {
		auth: {
			clientId: '<APP CLIENT ID>',
			authority: 'https://login.microsoftonline.com/dd2e8597-4137-4579-972b-a0198b5816aa'
		},
		cache: {
			cacheLocation: 'localStorage',
			storeAuthStateInCookie: false
		}
	};

	function getOAuthCardResourceUri(activity: any) {
		if (
			activity &&
			activity.attachments &&
			activity.attachments[0] &&
			activity.attachments[0].contentType === 'application/vnd.microsoft.card.oauth' &&
			activity.attachments[0].content.tokenExchangeResource
		) {
			return activity.attachments[0].content.tokenExchangeResource.uri;
		}
	}

	onMount(() => {
		const script = document.createElement('script');
		script.src = 'https://cdn.botframework.com/botframework-webchat/latest/webchat.js';
		script.crossOrigin = 'anonymous';
		document.head.appendChild(script);

		const tokenInfo = getTokenSync();

		script.onload = () => {
			function getOAuthCardResourceUri(activity: any) {
				if (
					activity &&
					activity.attachments &&
					activity.attachments[0] &&
					activity.attachments[0].contentType === 'application/vnd.microsoft.card.oauth' &&
					activity.attachments[0].content.tokenExchangeResource
				) {
					return activity.attachments[0].content.tokenExchangeResource.uri;
				}
			}

			let directLine = (window as any).WebChat.createDirectLine({ token: tokenInfo.token });

			const store = (window as any).WebChat.createStore(
				{},
				({ dispatch }: any) =>
					(next: any) =>
					(action: any) => {
						const { type } = action;
						if (action.type === 'DIRECT_LINE/CONNECT_FULFILLED') {
							dispatch({
								type: 'WEB_CHAT/SEND_EVENT',
								payload: {
									name: 'startConversation',
									type: 'event',
									value: { text: 'hello' }
								}
							});
							return next(action);
						}

						if (action.type === 'DIRECT_LINE/INCOMING_ACTIVITY') {
							const activity = action.payload.activity;
							let resourceUri;
							if (
								activity.from &&
								activity.from.role === 'bot' &&
								(resourceUri = getOAuthCardResourceUri(activity))
							) {
								if (token) {
									directLine
										.postActivity({
											type: 'invoke',
											name: 'signin/tokenExchange',
											value: {
												id: activity.attachments[0].content.tokenExchangeResource.id,
												connectionName: activity.attachments[0].content.connectionName,
												token
											},
											from: {
												id: userId,
												name: username,
												role: 'user'
											}
										})
										.subscribe(
											(id: any) => {
												if (id === 'retry') {
													return next(action);
												}
											},
											(error: any) => {
												return next(action);
											}
										);
									return;
								} else return next(action);
							} else return next(action);
						} else return next(action);
					}
			);

			const avatarOptions = {
				botAvatarImage:
					'https://cloudbanksimple-aks.eastus.cloudapp.azure.com/app/cloudbank-logo.png',
				botAvatarInitials: 'CB',
				botAvatarBackgroundColor: '#F4F6F8',
				userAvatarImage: 'Me',
				userAvatarInitials: 'Me'
			};

			(window as any).WebChat.renderWebChat(
				{
					directLine,
					userID: userId,
					tokenInfo: tokenInfo,
					msalConfig: msalConfig,
					username: username,
					locale: 'en-US',
					store,
					styleOptions: avatarOptions
				},
				document.getElementById('webchat')
			);
		};
	});
</script>

<div id="webchat" role="main" class="chat"></div>

<style>
	.chat {
		height: 100%;
		width: 100%;
	}
</style>
