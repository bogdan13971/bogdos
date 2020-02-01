void print(const char* string)
{
	//print it a few lines below the previous logs 
	char* VIDEO_MEMORY = (char*)(0xb8000+2*5*80);
	const char* p = string;

	while(*p != 0)
	{
		*VIDEO_MEMORY = *p;
		p++;
		VIDEO_MEMORY+=2;
	}
}

void main()
{
	print("Hello from the kernel !");
}
