import Image from "next/image";
const plantImageUrl = [
  "https://images.unsplash.com/photo-1485955900006-10f4d324d411?q=80&w=872&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1621274220348-41dc235ff439?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://images.unsplash.com/photo-1621274220348-41dc235ff439?q=80&w=2980&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
];
const plants = [
  { id: 1, name: "Aloe Vera", image: plantImageUrl[0] },
  { id: 2, name: "Snake Plant", image: plantImageUrl[1] },
  { id: 3, name: "Peace Lily", image: plantImageUrl[2] },
];
export default function YourPlants() {
  return (
    <div className="mb-20">
      <div className="mt-6 space-y-4">
        <h2 className="text-xl font-semibold">Your Plants</h2>
        <div className="space-y-4">
          {plants.map((plant) => (
            <div key={plant.name} className="flex items-center space-x-4">
              <Image
                src={plant.image}
                alt={plant.name}
                className="w-12 h-12 rounded-full object-cover"
                width={48}
                height={48}
              />
              <div>
                <h3 className="font-semibold">{plant.name}</h3>
                <p className="text-asparagus-300 text-sm">
                  Next watering in 2 days
                </p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
