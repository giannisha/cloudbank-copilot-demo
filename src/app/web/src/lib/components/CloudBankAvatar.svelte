<script>
	import { ProgressRadial } from '@skeletonlabs/skeleton';
	import { onMount } from 'svelte';

	let showProgressRadial = true;
	onMount(() => {
		setTimeout(() => {
			showProgressRadial = false;
		}, 40000);
	});
</script>

<div class="h-[60vh] w-[70vw]">
	<iframe
		title="CloudBank Avatar"
		src="http://cloudbanksimple-aks.eastus.cloudapp.azure.com/app/avatar/chat.html"
		frameborder="0"
		class="h-[60vh] w-[70vw] bg-white border-none overflow-hidden z-0 rounded-xl shadow-lg fixed"
		scrolling="no"
	></iframe>
	<div style:display={showProgressRadial ? 'block' : 'none'}>
		<ProgressRadial
			class="fixed z-10 m-auto mt-72"
			meter="stroke-primary-500"
			track="stroke-primary-500/30"
		/>
	</div>
</div>
