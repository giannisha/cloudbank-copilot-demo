<script lang="ts">
	import { Drawer } from '@skeletonlabs/skeleton';
	import Copilot from './Copilot.svelte';
	import type { AuthUser } from '$lib/types';

	export let user: AuthUser;
</script>

<Drawer position="right">
	{#if user}
		<div class="chat">
			<Copilot userId={user.id} username={user.username} token={user.token} />
		</div>
	{:else}
		<iframe
			title="Web Chat"
			src="https://copilotstudio.preview.microsoft.com/environments/Default-dd2e8597-4137-4579-972b-a0198b5816aa/bots/cr54e_copilotDemoV2/webchat?__version__=2"
			frameborder="0"
			style="width: 100%; height: 100%;"
		></iframe>
	{/if}
</Drawer>

<style>
	.chat {
		height: 100%;
		width: 100%;
	}
</style>
