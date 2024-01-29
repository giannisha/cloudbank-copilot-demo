<script lang="ts">
	export let data;
</script>

<div class="flex flex-col gap-5 p-3">
	<div class="card p-4 mt-6 bg-gray-50">
		<div class="flex flex-row align-middle">
			<h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
				Notifications
			</h5>
		</div>

		{#if data.records && data.records.length > 0}
			{#each data.records as record}
				<div class="card card-hover flex m-1">
					<div class="p-2 w-32"><img src={record.imgSrc} alt="thumbnail" /></div>
					<div class="p-2 flex-1">
						<h2>
							{record.title}
						</h2>
						<div>{record.description}</div>
						<p class="text-gray-500">{record.comments}</p>
						<div class="font-bold text-gray-600 text-xs">
							Created {new Date(record.date).toLocaleString()}
						</div>
					</div>
				</div>
			{/each}
		{/if}
		{#if data.records && data.records.length == 0}
			<p class="text-center m-4"></p>

			<div class="card">
				<section class="text-center p-4">No notifications found</section>
			</div>
		{/if}
	</div>
</div>
