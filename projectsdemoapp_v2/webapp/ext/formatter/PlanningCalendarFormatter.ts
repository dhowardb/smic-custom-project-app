export function formatCalendarDateTime(value: Date) {
	if (value) {
		value.setHours(1);
	}

	return value;
}

export function formatProjectName(value: string) {
	return value?.toUpperCase();
}
