import Image from "next/image";

interface PlantCardProps {
  name: string;
  image: string;
  prediction: string;
}

export default function PlantCard({
  name,
  image,
  prediction,
}: PlantCardProps) {
  return (
    <div className="bg-white rounded-3xl shadow-lg overflow-hidden">
      <div className="relative w-full h-64">
        <Image
          src={image}
          alt={name}
          width={400}
          height={400}
          className="w-full h-full object-cover"
        />
      </div>
      <div className="p-4">
        <h3 className="text-fern_green-DEFAULT font-semibold text-lg">
          {name}
        </h3>
        <p className="text-asparagus-600 text-sm">{prediction}</p>
      </div>
    </div>
  );
}
