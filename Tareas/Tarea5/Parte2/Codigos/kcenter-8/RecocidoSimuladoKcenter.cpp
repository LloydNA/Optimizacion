#include <iostream>
#include <vector>
#include <random>
#include <unordered_map>
#include <fstream>
#include <chrono>
using namespace std::chrono;

using namespace std;

struct Datas{
    double sum;
    unordered_map<long,vector<pair<long,double>>> centers;
    Datas(){
        sum = 0.0;
    }
};

vector<long> findCenters(Datas &curr, long &iC,int maxC,vector<pair<double,double>> &points){
    vector<long> result = vector<long>(1,iC);

    maxC--;

    while (maxC--){
        long candidate = 0;
        double tempdist = 0.0;
        for(int i=0;i<points.size();i++){
            double curr = INT_MAX*1.0;
            if(find(result.begin(),result.end(),i)!=result.end())
                continue;

            for(long &a:result)
                curr=min(curr,sqrt((points[i].first-points[a].first)*(points[i].first-points[a].first)+(points[i].second-points[a].second)*(points[i].second-points[a].second)));

            if(curr>tempdist){
                tempdist=curr;
                candidate=i;
            }
        }

        result.push_back(candidate);
    }

    return result;
}

Datas f(long iC, vector<pair<double,double>> &points,int &maxC){
    Datas result = Datas();

    auto centers = findCenters(result,iC,maxC, points);

    for(int i=0;i<points.size();i++){
        long candidate = 0;
        double distance = INT_MAX*1.0;

        for(long &a:centers){
            if(sqrt((points[i].first-points[a].first)*(points[i].first-points[a].first)+(points[i].second-points[a].second)*(points[i].second-points[a].second))<distance){
                distance = sqrt((points[i].first-points[a].first)*(points[i].first-points[a].first)+(points[i].second-points[a].second)*(points[i].second-points[a].second));
                candidate=a;
            }
        }

        result.centers[candidate].push_back({i,distance});
        result.sum+=distance;
    }

    return result;
}

Datas RecSim(){
    srand((unsigned) time(0));

    int maxCenters;
    vector<pair<double,double>> points;
    vector<double> weights;
    string buff="";

    ifstream file("/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/PoderososC/kcenter-8");

    file>>buff;
    weights=vector<double>(stoi(buff),0.0);

    buff.clear();

    file>>buff;
    maxCenters=stoi(buff);

    buff.clear();

    while(file.good()){
        double x,y;

        file>>buff;
        buff.clear();

        file>>buff;
        x=stod(buff);
        buff.clear();

        file>>buff;
        y=stod(buff);
        buff.clear();

        points.push_back({x,y});
    }

    random_device rd;
    default_random_engine generator(rd());
    normal_distribution<double> distribution(0.0,1.0);
    int iter=20;
    double temperature = 10.0;
    double alpha = 0.9;

    for(double &i : weights)
        i+=distribution(generator);

    Datas best = f(max_element(weights.begin(),weights.end())-weights.begin(),points,maxCenters);

    while(iter--){
        auto wk = weights;

        for(double &i : wk)
            i+=distribution(generator);

        Datas candidate = f(max_element(wk.begin(),wk.end())-wk.begin(),points,maxCenters);

        if(candidate.sum<best.sum||((double)(rand()%10)/10 < exp((candidate.sum-best.sum)/temperature))){
            best = candidate;
            weights = wk;
        }

        temperature*=alpha;
    }

    return best;
}

int main() {
    for(int i=0;i<50;i++){
        Datas result = RecSim();
        ofstream exporter;
        exporter.open("/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/PoderososC/kcenter8/kcenter-8r"+to_string(i)+".txt");

        exporter<<result.sum<<'\n';
        for(auto a:result.centers){
            exporter<<a.first<<' ';
            for(auto &b:a.second)
                exporter << b.first << ' ';
            exporter<<'\n';
        }

        exporter.close();
    }
    system("say -v Paulina Ya acabe");
    return 0;

    auto start = high_resolution_clock::now();
    Datas result = RecSim();
    ofstream exporter;
    exporter.open("/Users/lloydna/Desktop/UP/5° Semestre/Optimizacion/PoderososC/kcenter-8r.txt");

    exporter<<result.sum<<'\n';
    for(auto a:result.centers){
        exporter<<a.first<<' ';
        for(auto &b:a.second)
            exporter<<b.first<<' ';
        exporter<<'\n';
    }

    exporter.close();
    auto stop = high_resolution_clock::now();
    cout << result.sum<<' '<<duration_cast<seconds>(stop-start).count();
    return 0;
}