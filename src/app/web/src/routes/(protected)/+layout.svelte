<script lang="ts">
	import { writable } from 'svelte/store';
	import '../../app.postcss';
	import {
		AppShell,
		AppBar,
		initializeStores,
		type DrawerSettings,
		getDrawerStore,
		LightSwitch,
		Modal,
		type ModalSettings,
		getModalStore,
		type ModalComponent
	} from '@skeletonlabs/skeleton';
	import { setContext } from 'svelte';
	import CopilotDrawer from '$lib/components/CopilotDrawer.svelte';
	import CloudBankAvatar from '$lib/components/CloudBankAvatar.svelte';

	export let data;

	initializeStores();
	const drawerSettings: DrawerSettings = {
		bgDrawer: 'bg-secondary-500 text-white',
		width: 'w-[280px] md:w-[480px]',
		padding: 'p-4',
		rounded: 'rounded-xl'
	};
	const drawerStore = getDrawerStore();

	const toggleDrawer = () => {
		drawerStore.open(drawerSettings);
	};

	const user = writable();
	user.set(data.user);

	setContext('user', user);

	const modalRegistry: Record<string, ModalComponent> = {
		avatarModal: { ref: CloudBankAvatar }
	};

	const modalStore = getModalStore();
	const avatarBtnClick = () => {
		const modal: ModalSettings = {
			type: 'component',
			component: 'avatarModal'
		};
		modalStore.trigger(modal);
	};
</script>

<AppShell>
	<svelte:fragment slot="header">
		<AppBar class="space-y-4">
			<svelte:fragment slot="lead">
				<a href="/app/home">
					<div class="flex flex-row items-center gap-2">
						<img src="/app/cloudbank-logo-large.png" alt="cloudbank-logo" width="50" height="30" />
						<strong class="text-xl uppercase">CloudBank</strong>
					</div>
				</a>
			</svelte:fragment>
			<svelte:fragment slot="trail">
				<a href="/app/home">
					<h3>Home</h3>
				</a>
				<a href="/app/notifications">
					<h3>Notifications</h3>
				</a>
				<div class="w-[2px] h-6 bg-gray-800 dark:bg-gray-600 mx-3 rounded-xl"></div>
				<button type="button" class="btn-icon btn-sm" on:click={avatarBtnClick}>
					<svg
						class="w-6 h-6 text-gray-800 dark:text-white"
						aria-hidden="true"
						xmlns="http://www.w3.org/2000/svg"
						fill="currentColor"
						viewBox="0 0 20 18"
					>
						<path
							d="M14 2a3.963 3.963 0 0 0-1.4.267 6.439 6.439 0 0 1-1.331 6.638A4 4 0 1 0 14 2Zm1 9h-1.264A6.957 6.957 0 0 1 15 15v2a2.97 2.97 0 0 1-.184 1H19a1 1 0 0 0 1-1v-1a5.006 5.006 0 0 0-5-5ZM6.5 9a4.5 4.5 0 1 0 0-9 4.5 4.5 0 0 0 0 9ZM8 10H5a5.006 5.006 0 0 0-5 5v2a1 1 0 0 0 1 1h11a1 1 0 0 0 1-1v-2a5.006 5.006 0 0 0-5-5Z"
						/>
					</svg>
				</button>
				<button type="button" class="btn-icon btn-sm" on:click={toggleDrawer}>
					<svg
						class="w-5 h-5 dark:text-white text-gray-800"
						aria-hidden="true"
						xmlns="http://www.w3.org/2000/svg"
						fill="none"
						viewBox="0 0 20 18"
					>
						<path
							stroke="currentColor"
							stroke-linecap="round"
							stroke-linejoin="round"
							stroke-width="2"
							d="M5 5h5M5 8h2m6-3h2m-5 3h6m2-7H2a1 1 0 0 0-1 1v9a1 1 0 0 0 1 1h3v5l5-5h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1Z"
						/>
					</svg>
				</button>
				<LightSwitch />
				<div class="w-[2px] h-6 bg-gray-800 dark:bg-gray-600 mx-3 rounded-xl"></div>
				<a href="/app/logout">
					<h3>Logout</h3>
				</a>
			</svelte:fragment>
		</AppBar>
	</svelte:fragment>
	{#if data.user}
		<CopilotDrawer user={data.user} />
	{/if}
	<Modal components={modalRegistry} />
	<slot />
</AppShell>
