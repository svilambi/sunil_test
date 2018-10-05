public class ThreadSleep {
	public static void main(String[] args) throws InterruptedException {
		System.out.println(args[1]);
		for (int i = 0; i < Integer.parseInt(args[0]); i++) {
			System.out.println(i);
			Thread.sleep(1000);
		}
	}
}
