void main() {
	// Create a pointer to the first cell of video memory we can write to
	char* video_memory = (char*) 0xb8000;

	// Store our welcome message at the video memory address
	*video_memory = 'X';
}