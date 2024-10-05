import Link from "next/link";

export default function NotFound() {
  return (
    <div className="flex flex-col items-center justify-center h-screen text-center text-2xl font-bold text-asparagus">
      404 - Page Not Found
      <Link href="/" className="text-asparagus-500 hover:text-asparagus-800">
        Go to Home
      </Link>
    </div>
  );
}
