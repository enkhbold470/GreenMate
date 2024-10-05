import Image from "next/image";
const plants = [
  { id: 1, name: "Aloe Vera", image: "/EG.svg" },
  { id: 2, name: "Snake Plant", image: "/EG.svg" },
  { id: 3, name: "Peace Lily", image: "/EG.svg" },
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
